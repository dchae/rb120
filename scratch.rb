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
    self.speed -= [3, self.speed - 0].min
  end
  
  def turn_off
    self.speed = 0
  end
end

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
