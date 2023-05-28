module MakeSound
  def init_sound(sound)
    @sound = sound
  end

  def make_sound
    puts @sound
  end
end

class Dog
  include MakeSound
  def initialize(sound)
    init_sound(sound)
  end
end

class Cat
  include MakeSound
  def initialize(sound)
    init_sound(sound)
  end
end


rufus = Dog.new("ruff")
meowth = Cat.new("meow")
rufus.make_sound
meowth.make_sound

p rufus
p meowth