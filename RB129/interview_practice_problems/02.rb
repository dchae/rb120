# Problem received from Raul Romero
class Human
  attr_reader :name

  def initialize(name = "Dylan")
    @name = name
  end

  def hair_colour(hair_colour = "blonde")
    self.class.hair_colour(@name, hair_colour)
  end

  def self.hair_colour(name = "Dylan", hair_colour = "blonde")
    name = "Dylan" if name.empty?
    "Hi, my name is #{name} and I have #{hair_colour} hair."
  end
end

puts Human.new("Jo").hair_colour("blonde")
# Should output "Hi, my name is Jo and I have blonde hair."

puts Human.hair_colour("")
# Should "Hi, my name is Dylan and I have blonde hair."
