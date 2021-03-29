require "./enumerables"

describe Enumerable do
  describe "my_each" do
    it "puts every item in the array" do
      array = [1, 2, 3, 4]
      expect(array.my_each { |item| puts item }).to eql([1, 2, 3, 4])
    end
  end
end
