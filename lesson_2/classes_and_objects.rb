# 1.

# class Person
#   attr_accessor :name

#   def initialize(name)
#     @name = name
#   end
# end
# bob = Person.new("bob")
# p bob.name # => 'bob'
# bob.name = "Robert"
# p bob.name # => 'Robert'

# 2.

# class Person
#   attr_accessor :first_name, :last_name

#   def initialize(first_name, last_name = "")
#     @first_name = first_name
#     @last_name = last_name
#   end

#   def name
#     [first_name, last_name].join(" ").strip
#   end
# end

# bob = Person.new("Robert")
# p bob.name # => 'Robert'
# p bob.first_name # => 'Robert'
# p bob.last_name # => ''
# bob.last_name = "Smith"
# p bob.name # => 'Robert Smith'

# 3.
# class Person
#   attr_accessor :first_name, :last_name

#   def initialize(full_name)
#     self.name = full_name
#   end

#   def name
#     [first_name, last_name].join(" ").strip
#   end

#   def name=(full_name)
#     name_arr = full_name.split
#     self.first_name, self.last_name = name_arr.fill("", name_arr.size..2)
#   end
# end

# bob = Person.new("Robert")
# p bob.name # => 'Robert'
# p bob.first_name # => 'Robert'
# p bob.last_name # => ''
# bob.last_name = "Smith"
# p bob.name # => 'Robert Smith'

# bob.name = "John Adams"
# p bob.first_name # => 'John'
# p bob.last_name # => 'Adams'

# 4.

# class Person
#   attr_accessor :first_name, :last_name

#   def initialize(full_name)
#     self.name = full_name
#   end

#   def name
#     [first_name, last_name].join(" ").strip
#   end

#   def name=(full_name)
#     name_arr = full_name.split
#     self.first_name, self.last_name = name_arr.fill("", name_arr.size..2)
#   end
# end

# bob = Person.new("Robert Smith")
# rob = Person.new("Robert Smith")
# p bob.name == rob.name

# 5.

# bob = Person.new("Robert Smith")
# puts "The person's name is: #{bob}" # => some object representation

# 6.

class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    self.name = full_name
  end

  def name
    [first_name, last_name].join(" ").strip
  end

  def name=(full_name)
    name_arr = full_name.split
    self.first_name, self.last_name = name_arr.fill("", name_arr.size..2)
  end

  def to_s
    name
  end
end
bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}" #=> "The person's name is: Robert Smith"
