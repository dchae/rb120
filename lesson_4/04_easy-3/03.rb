class AngryCat
  def initialize(age, name)
    @age = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

meow = AngryCat.new(2, "Puss")
hiss = AngryCat.new(5, "Garfield")
