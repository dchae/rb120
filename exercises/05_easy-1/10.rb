class Vehicle
  attr_reader :make, :model, :wheels

  def initialize(make, model)
    @make = make
    @model = model
    @wheels = 4
  end

  def to_s
    "#{make} #{model}"
  end
end

class Car < Vehicle
end

class Motorcycle < Vehicle
  def initialize(make, model)
    super
    @wheels = 2
  end
end

class Truck < Vehicle
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
    @wheels = 6
  end
end

fiata = Car.new("Fiat", "124 Spider")
optimus = Truck.new("Autobots", "Roll out", 1000)
harley = Motorcycle.new("Harley Davidson", "Low Rider")

[fiata, optimus, harley].each do |vehicle|
  puts vehicle
  puts vehicle.wheels
end
puts optimus.payload
