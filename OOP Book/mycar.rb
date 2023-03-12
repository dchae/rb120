module Paintable
  def spray_paint(new_color)
    self.color = new_color
  end
end

module Convertible
  def put_top_down
    self.top_down = true
  end

  def put_top_up
    self.top_down = false
  end
end

class Vehicle
  include Paintable

  @@count = 0

  attr_accessor :color, :speed
  attr_reader :year

  def self.mpg(miles, gallons)
    miles / gallons.to_f
  end

  def initialize(year, color, model)
    @@count += 1
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def accelerate
    self.speed += 5
  end

  def brake
    self.speed -= [3, self.speed - 0].min
  end

  def turn_off
    self.speed = 0
  end

  def to_s
    "#{color.capitalize} #{year} #{@model}; Speed: #{speed}"
  end

  def self.print_count
    puts @@count
  end

  def age
    cur_year - year
  end

  private

  def cur_year
    Time.new.year
  end
end

class MyCar < Vehicle
  include Convertible

  PURPOSE = "Leisure"

  def initialize(*)
    super
    @top_down = false
  end

  def top_down?
    @top_down
  end

  def top_down=(bool)
    @top_down = bool
  end
end

class MyTruck < Vehicle
  PURPOSE = "Work"
end

p MyCar.mpg(350, 10)

fiata = MyCar.new(2018, "black", "124 Spider")
p fiata.year
p fiata.color
fiata.spray_paint("red")
p fiata.color
p fiata.speed
fiata.accelerate
p fiata.speed
fiata.brake
p fiata.speed
fiata.turn_off
p fiata.speed
puts fiata

Vehicle.print_count
ford = MyTruck.new(2020, "white", "F150")
Vehicle.print_count

[Vehicle, MyCar, MyTruck].each { |cls| p cls.ancestors }

p fiata.top_down?
fiata.put_top_down
p fiata.top_down?
fiata.put_top_up
p fiata.top_down?

p fiata.age
p ford.age
