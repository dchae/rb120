class Student
  attr_accessor :name

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(other_student)
    grade > other_student.grade
  end

  protected

  def grade
    @grade
  end
end

joe = Student.new("Joe", 95)
bob = Student.new("Bob", 67)
# p joe.grade
puts "Well done!" if joe.better_grade_than?(bob)

# Problem 8

# The problem is that Person#hi is a private method.
# We can either create a new public method that provides similar functionality and call that,
# or we can make hi a public method by moving it above the private keyword in the class.
