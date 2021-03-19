module Enumerable
  def my_each
    array = to_a
    array.size.times { |index| yield array[index] }
    array
  end

  def my_each_with_index
    index = 0
    my_each do |value|
      yield(value, index)
      index += 1
    end
  end

  def my_select
    result = []
    my_each { |item| result << item if yield item }
    result
  end

  def my_all(pattern = nil)
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
end
