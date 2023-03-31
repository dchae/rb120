class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

# An instance of the `Pizza` class would have an instance variable, while an instance of the `Fruit` class would not.
# Line 3 initialises a local variable, not an instance variable.

orange = Fruit.new("Orange")
large_pepperoni = Pizza.new("Large Pepperoni")

p orange.instance_variables
p large_pepperoni.instance_variables
