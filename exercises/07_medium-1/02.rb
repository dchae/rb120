class FixedArray
  attr_reader :arr, :size
  def initialize(n)
    @arr = [nil] * n
    @size = n
  end

  def [](i)
    raise IndexError if i >= size
    arr[i]
  end

  def []=(i, x)
    raise IndexError if i >= size
    arr[i] = x
  end

  def to_a
    arr[0..]
  end

  def to_s
    arr.to_s
  end

  private

  attr_writer :arr
end

fixed_array = FixedArray.new(5)
puts fixed_array[3] == nil
puts fixed_array.to_a == [nil] * 5

fixed_array[3] = "a"
puts fixed_array[3] == "a"
puts fixed_array.to_a == [nil, nil, nil, "a", nil]

fixed_array[1] = "b"
puts fixed_array[1] == "b"
puts fixed_array.to_a == [nil, "b", nil, "a", nil]

fixed_array[1] = "c"
puts fixed_array[1] == "c"
puts fixed_array.to_a == [nil, "c", nil, "a", nil]

fixed_array[4] = "d"
puts fixed_array[4] == "d"
puts fixed_array.to_a == [nil, "c", nil, "a", "d"]
puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

puts fixed_array[-1] == "d"
puts fixed_array[-4] == "c"

begin
  fixed_array[6]
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[-7] = 3
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[7] = 3
  puts false
rescue IndexError
  puts true
end
