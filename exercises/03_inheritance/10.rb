module Transportation
  class Vehicle
  end

  class Truck < Vehicle
  end

  class Car < Vehicle
    def initialize
      puts "New car object was created!"
    end
  end
end

new_car = Transportation::Car.new
