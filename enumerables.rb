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
end
