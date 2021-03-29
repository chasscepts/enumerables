require "./enumerables"

describe Enumerable do
  describe "#my_each" do
    it "puts every item in the array" do
      array = [1, 2, 3, 4]
      expect(array.my_each { |item| puts item }).to eql([1, 2, 3, 4])
    end
  end

  describe "#my_each_with_index" do
    it "puts every item with the index" do
      array = ["jordy","addis","hanna"]
      expect(array.my_each_with_index{|item,index| puts "#{index+1}. #{item}"}).to eql(["jordy", "addis", "hanna"]
      )
    end
  end
end
