class Transform
  def initialize(s)
    @string = s
  end

  def uppercase
    @string.upcase
  end

  def self.lowercase(s)
    s.downcase
  end
end

my_data = Transform.new("abc")
puts my_data.uppercase
puts Transform.lowercase("XYZ")
