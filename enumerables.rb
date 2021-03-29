module Enumerable
  def my_each
    if block_given?
      array = to_a
      array.size.times { |index| yield array[index] }
      return self
    end
    to_enum
  end

  def my_each_with_index
    if block_given?
      array = to_a
      array.size.times { |index| yield(array[index], index) }
      return self
    end
    to_enum
  end

  def my_select
    if block_given?
      result = []
      my_each { |item| result << item if yield item }
      return result
    end
    to_enum
  end

  def my_all?(pattern = nil, &block)
    if block_given? || pattern.nil?
      helper = block_given? ? block : proc { |value| value }
      my_each { |value| return false unless helper.call(value) }
    else
      my_each { |value| return false unless match_pattern?(value, pattern) }
    end

    true
  end

  def my_any?(pattern = nil, &block)
    if block_given? || pattern.nil?
      helper = block_given? ? block : proc { |value| value }
      my_each { |value| return true if helper.call(value) }
    else
      my_each { |value| return true if match_pattern?(value, pattern) }
    end

    false
  end

  def my_none?(pattern = nil)
    if block_given?
      my_each { |value| return false if yield(value) }
      return true
    end
    unless pattern.nil?
      my_each { |value| return false if match_pattern?(value, pattern) }
      return true
    end
    my_each { |value| return false if value }
    true
  end

  def my_count(item = nil)
    items_count = 0
    if !item.nil?
      my_each { |value| items_count += 1 if value == item }
    elsif block_given?
      my_each { |value| items_count += 1 if yield(value) }
    else
      my_each { items_count += 1 }
    end
    items_count
  end

  def my_map(proc = nil, &block)
    return my_map_helper(proc) unless proc.nil?
    return my_map_helper(block) if block_given?

    to_enum
  end

  def my_inject(*args, &block)
    array = to_a

    return my_inject_with_block(array, args, block) if block_given?

    raise LocalJumpError, "no block given" if args.empty?

    memo = args.size == 2 ? args[0] : array[0]
    sym = args.size == 2 ? args[1] : args[0]
    index = args.size == 2 ? 0 : 1

    (index...array.size).my_each { |idx| memo = memo.send(sym, array[idx]) }

    memo
  end

  def multiply_els(array)
    array.my_inject(:*)
  end

  private

  def match_pattern?(item, pattern)
    return true if pattern.is_a?(Regexp) && item =~ pattern
    return true if pattern.is_a?(Class) && item.is_a?(pattern)
    return true if item == pattern

    false
  end

  def my_inject_with_block(array, args, block)
    memo = args.empty? ? array[0] : args[0]
    index = args.empty? ? 1 : 0

    (index...array.size).my_each { |idx| memo = block.call(memo, array[idx]) }

    memo
  end

  def my_map_helper(block_or_proc)
    new_array = []
    my_each { |value| new_array << block_or_proc.call(value) }
    new_array
  end
end
