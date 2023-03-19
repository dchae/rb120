# 1.
# class Dog
#   def speak
#     "bark!"
#   end

#   def swim
#     "swimming!"
#   end
# end

# class Bulldog < Dog
#   def swim
#     "can't swim!"
#   end
# end

# 2.

# class Pet
#   def run
#     "running!"
#   end

#   def jump
#     "jumping!"
#   end
# end

# class Dog < Pet
#   def speak
#     "bark!"
#   end

#   def swim
#     "swimming!"
#   end

#   def fetch
#     "fetching!"
#   end
# end

# class Bulldog < Dog
#   def swim
#     "can't swim!"
#   end
# end

# class Cat < Pet
#   def speak
#     "meow!"
#   end
# end
# pete = Pet.new
# kitty = Cat.new
# dave = Dog.new
# bud = Bulldog.new

# p pete.run # => "running!"
# # pete.speak # => NoMethodError

# p kitty.run # => "running!"
# p kitty.speak # => "meow!"
# # kitty.fetch # => NoMethodError

# p dave.speak # => "bark!"

# p bud.run # => "running!"
# p bud.swim # => "can't swim!"

# 3.
#  Pet
#  |  \
# Dog, Cat
#  |
# Bulldog

# 4.
# The method lookup path looks for methods defined in the class,
# then in the included modules from last to first,
# then repeates for each parent class in order of inheritance.
