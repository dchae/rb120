class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class GoodDog < Animal
  def initialize(name, color)
    super(name)
    @color = color
  end
end

p bruno = GoodDog.new("charlie", "brown") # => #<GoodDog:0x007fb40b1e6718 @color="brown", @name="brown">
