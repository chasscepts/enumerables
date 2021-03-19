module Enumerable
  def my_each
    array = to_a
    array.size.times { |index| yield array[index] }
    array
  end

  def my_each_with_index
    array = to_a
    array.size.times { |index| yield(array[index], index) }
    array
  end

  def my_select
    result = []
    my_each { |item| result << item if yield item }
    result
  end

  def my_all?(pattern = nil)
    if block_given?
      my_each { |value| return false unless yield(value) }
      return true
    end
    unless pattern.nil
      my_each { |value| return false unless match_pattern(value, pattern) }
      return true
    end
    my_each { |value| return false unless value }
    true
  end

  def my_any?(pattern = nil)
    if block_given?
      my_each { |item| return true if yield(item) }
      return false
    end
    unless pattern.nil?
      my_each { |item| return true if match_pattern(item, pattern) }
      return false
    end
    my_each { |item| return true if item }
    false
  end

  def my_none?(pattern = nil)
    if block_given?
      my_each { |value| return false if yield(value) }
      return true
    end
    unless pattern.nil?
      my_each { |value| return false if match_pattern(value, pattern) }
      return true
    end
    my_each { |_value| return false if item }
    true
  end

  def my_count(item = nil)
    items_count = 0
    if !item.nil?
      my_each { items_count += 1 if value == item }
    elsif block_given?
      my_each { items_count += 1 if yield(value) }
    else
      my_each { items_count += 1 }
    end
    items_count
  end

  def my_map(proc = nil)
    new_array = []
    if !proc.nil
      my_each { |value| new_array << proc.call(value) }
      new_array
    elsif block_given?
      my_each { |value| new_array << yield(value) }
      new_array
    else
      to_enum
    end
  end

  def my_inject(*args)
    array = to_a

    return my_inject_with_block(array, args) if block_given?

    raise LocalJumpError, 'no block given' if args.empty?

    memo = args.size == 2 ? args[0] : array[0]
    sym = args.size == 2 ? args[1] : args[0]
    index = args.size == 2 ? 0 : 1

    (index...array.size).my_each { |idx| memo = memo.send(sym, array[idx]) }

    memo
  end

  private

  def match_pattern(item, pattern)
    return true if item == pattern || item =~ pattern

    begin
      return true if item.is_a?(pattern)
    rescue TypeError
      return false
    end
    false
  end

  def my_inject_with_block(array, args)
    memo = args.empty? ? array[0] : args[0]
    index = args.empty? ? 1 : 0

    (index...array.size).my_each { |idx| memo = yield(memo, array[idx]) }

    memo
  end
end

def multiply_els(array)
  array.my_inject(:*)
end
