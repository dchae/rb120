##### How do we create an object in Ruby? Give an example of the creation of an object.
```ruby
class Coffee
  # It gives you energy!
end

my_coffee = Coffee.new
```

##### What is a module? What is its purpose? How do we use them with our classes? 
A module is a mixin class that is used to make methods available across different classes. We use them by "mixing them in" to our classes with the `include` keyword.

##### Create a module for the class you created in exercise 1 and include it properly.
```ruby
module Drinkable
  def drink
    puts "Glug glug..."
  end
end

class Coffee
  # It gives you energy!
  include Drinkable
end

my_coffee = Coffee.new
my_coffee.drink
# => "Glug glug..."
```

##### Create a class called MyCar. When you initialize a new instance or object of the class, allow the user to define some instance variables that tell us the year, color, and model of the car. Create an instance variable that is set to 0 during instantiation of the object to track the current speed of the car as well. Create instance methods that allow the car to speed up, brake, and shut the car off.

##### Add an accessor method to your MyCar class to change and view the color of your car. Then add an accessor method that allows you to view, but not modify, the year of your car.


##### You want to create a nice interface that allows you to accurately describe the action you want your program to perform. Create a method called spray_paint that can be called on an object and will modify the color of the car.


```ruby
module Paintable
  def spray_paint(new_color)
    self.color = new_color
  end
end

class MyCar
  include Paintable

  attr_accessor :color, :speed
  attr_reader :year

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def accelerate
    self.speed += 5
  end
  
  def brake
    self.speed -= [5, self.speed - 0].min
  end
  
  def turn_off
    self.speed = 0
  end
end

fiata = MyCar.new(2018, "black", "124 Spider")
p fiata.year #=> 2018
p fiata.color #=> "black"
fiata.spray_paint("red")
p fiata.color #=> "red"
```
