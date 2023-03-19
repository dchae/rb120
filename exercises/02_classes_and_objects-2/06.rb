class Cat
  DEFAULT_COLOR = "purple"
  attr_accessor :name, :color

  def initialize(name, color = DEFAULT_COLOR)
    @name = name
    @color = color
  end

  def greet
    puts "Hello! My name is #{name} and I'm a #{color} cat!"
  end
end

kitty = Cat.new("Sophie")
kitty.greet
