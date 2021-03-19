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
end
