# What will the following code output? Why?

class Student
  attr_reader :id

  def initialize(name)
    @name = name
    @id
  end

  def id=(value)
    self.id = value
  end
end

tom = Student.new("Tom")
tom.id = 45

# Will result in a stackerror as id= is calling itself recursively without a termination condition.
