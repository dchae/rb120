class Pet
  attr_reader :type, :name

  def initialize(type, name)
    @type, @name = type, name
  end

  def to_s
    "a #{type} named #{name}"
  end
end

class Owner
  attr_reader :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end

  def add_pet(pet)
    pets << pet
  end

  def number_of_pets
    pets.size
  end
end

class Shelter
  def initialize
    @clients = {}
    @pets = Hash.new(false)
  end

  def register(pet, available = true)
    pets[pet] = available
  end

  def adopt(owner, pet)
    owner.add_pet(pet)
    clients[owner.name] ||= owner
    pets[pet] = false
  end

  def print_adoptions
    clients.each do |owner_name, owner|
      puts "#{owner_name} has adopted the following pets:"
      puts owner.pets.join("\n")
      puts
    end
  end

  def print_available_pets
    puts "The Animal Shelter has the following unadopted pets:"
    pets.each { |pet, adoption_status| puts pet }
    puts
    clients.each do |owner_name, owner|
      puts "#{owner_name} has #{owner.number_of_pets} adopted pets"
    end
    puts "The Animal Shelter has #{pets.select { |k, v| v }.size} unadopted pets."
  end

  private

  attr_accessor :clients, :pets
end

butterscotch = Pet.new("cat", "Butterscotch")
pudding = Pet.new("cat", "Pudding")
darwin = Pet.new("bearded dragon", "Darwin")
kennedy = Pet.new("dog", "Kennedy")
sweetie = Pet.new("parakeet", "Sweetie Pie")
molly = Pet.new("dog", "Molly")
chester = Pet.new("fish", "Chester")
nico = Pet.new("dog", "Nico")
yoshi = Pet.new("leopard gecko", "Yoshi")

phanson = Owner.new("P Hanson")
bholmes = Owner.new("B Holmes")

shelter = Shelter.new
[
  butterscotch,
  pudding,
  darwin,
  kennedy,
  sweetie,
  molly,
  chester,
  nico,
  yoshi,
].each { |pet| shelter.register(pet) }

shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
puts
shelter.print_available_pets
