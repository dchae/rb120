class Cat
  attr_reader :type
  def initialize(type)
    @type = type
  end

  def to_s
    "I am a #{type} cat"
  end
end

test_cat = Cat.new("tabby")
puts test_cat
