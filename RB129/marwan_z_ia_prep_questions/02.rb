# Define a class of your choice with the following:
# - Constructor method that initializes 2 instance variables.
# - Instance method that outputs an interpolated string of those variables.
# - Getter methods for both (you can use shorthand notation if you want).
# - Prevent instances from accessing these methods outside of the class.
# - Finally, explain what concepts you've just demonstrated with your code.

class Student
  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def to_s
    "Name: #{name}, Grade: #{grade}"
  end

  private

  attr_reader :name, :grade
end

tom = Student.new("Tom", 10)
p tom
puts tom 
# p tom.name #=> error

s = "some_string"
[s, tom].each { |x| puts x.to_s }