class Person
  def name=(full_name)
    @first_name, @last_name = full_name.split
  end

  def name
    [@first_name, @last_name].join(" ")
  end
end

person1 = Person.new
person1.name = "John Doe"
puts person1.name
