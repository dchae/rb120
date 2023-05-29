class Cat
  attr_accessor :name

  def set_name
    name = "Cheetos" # prepend self. to fix
  end
end

cat = Cat.new
cat.set_name
p cat.name # returns?