module Enumerable
  def my_each
    array = to_a
    array.size.times { |index| yield array[index] }
    array
  end
end
