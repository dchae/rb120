class Animal
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new
cat1.color
# Lookup Path => Cat, Animal, Object, Kernel, BasicObject
