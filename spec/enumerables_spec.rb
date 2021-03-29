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
      array = ["jordy", "addis", "hanna"]
      expect(array.my_each_with_index { |item, index| puts "#{index + 1}. #{item}" }).to eql(["jordy", "addis", "hanna"])
    end
  end

  describe "#my_select" do
    it "puts selected item greater than two" do
      array = [1, 2, 3]
      expect(array.my_select { |item| item > 2 }).to eql([3])
    end
  end

  describe "#my_all?" do
    it "return false if not all items are greater than 3" do
      array = [1, 2, 3]
      expect(array.my_all? { |item| item > 3 }).to eql(false)
    end

    it "returns true if all items are greater than 0" do
      array = [1, 2, 3]
      expect(array.my_all? { |item| item > 0 }).to eql(true)
    end

    it "returns true if all items are Numerics" do
      array = [1, 2, 3]
      expect(array.my_all?(Numeric)).to eql(true)
    end

    it "returns true if all items contain the letter 'd'" do
      array = ["jordy", "addis", "hannad"]
      expect(array.my_all?(/d/)).to eql(true)
    end
  end
  describe "#my_any?" do
    it "return false if any of the items are greater than 3" do
      array = [1, 2, 3]
      expect(array.my_any? { |item| item > 3 }).to eql(false)
    end

    it "returns true if any of the items are greater than 2" do
      array = [1, 2, 3]
      expect(array.my_any? { |item| item > 2 }).to eql(true)
    end

    it "returns true if any of the items are Numerics" do
      array = [1, 2, 3, "a", "j"]
      expect(array.my_any?(Numeric)).to eql(true)
    end

    it "returns true if any of the items contain the letter 'd'" do
      array = ["jordy", "addis", "hanna"]
      expect(array.my_any?(/d/)).to eql(true)
    end
  end

  describe "#my_none?" do
    it "return true if none of the items are greater than 3" do
      array = [1, 2, 3]
      expect(array.my_none? { |item| item > 3 }).to eql(true)
    end

    it "returns false if any of the items are greater than 2" do
      array = [1, 2, 3]
      expect(array.my_none? { |item| item > 2 }).to eql(false)
    end

    it "returns false if any of the items are Numerics" do
      array = [1, 2, 3, "a", "j"]
      expect(array.my_none?(Numeric)).to eql(false)
    end

    it "returns false if any of the items contain the letter 'd'" do
      array = ["jordy", "addis", "hanna"]
      expect(array.my_none?(/d/)).to eql(false)
    end
  end
  describe "#my_count" do
    it "count items in the array" do
      array = [1, 2, 2, 4]
      expect(array.my_count).to eql(4)
    end

    it "count items equal to 2" do
      array = [1, 2, 2, 4]
      expect(array.my_count(2)).to eql(2)
    end
    it "count items greater than 1" do
      array = [1, 2, 2, 4]
      expect(array.my_count { |item| item > 1 }).to eql(3)
    end
  end

  describe "#my_map" do
    it "add 2 to all items" do
      array = [1, 2, 2, 4]
      expect(array.my_map { |item| item += 2 }).to eql([3, 4, 4, 6])
    end

    it "add 3 to all items using proc" do
      array = [1, 2, 2, 4]
      my_proc = proc { |item| item += 3 }
      expect(array.my_map(my_proc)).to eql([4, 5, 5, 7])
    end
  end

  describe "#my_inject" do
    it "it returns the sum of all items" do
      array = [1, 2, 3, 4]
      expect(array.my_inject { |sum, item| sum + item }).to eql(10)
    end
    it "it returns the sum of the array with the given value" do
      array = [1, 2, 3, 4]
      expect(array.my_inject(10) { |sum, item| sum + item }).to eql(20)
    end
    it "returns the sum of the array using the given symbol" do
      array = [1, 2, 3, 4]
      expect(array.my_inject(:+)).to eql(10)
    end
  end

  describe "#multiply_els" do
    it "returns product of all items in array" do
      array = [1, 2, 3, 4, 5]
      expect(array.multiply_els(array)).to eql(120)
    end
  end
end
