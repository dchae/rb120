# The `@@cats_count` class variable will keep track of the number of instances of the `Cat` class that have been initialised.
# It does this because initialising an object of the `Cat` class will automatically call the `initialize` method that has been defined on line 4.
# That `initialize` method will increment the `@@cats_count` class variable.

# In order to test this, we can initialise multiple `Cat` objects and check the value of `@@cats_count` before and after each initialisation.

class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

p Cat.cats_count
Garfield = Cat.new("Tabby")
p Cat.cats_count
Hobbes = Cat.new("Tiger")
p Cat.cats_count
Cheshire = Cat.new("British Shorthair")
p Cat.cats_count
