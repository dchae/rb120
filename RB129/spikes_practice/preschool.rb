# Inside a preschool there are children, teachers, class assistants, a principle, janitors, and cafeteria workers.
# Both teachers and assistants can help a student with schoolwork and watch them on the playground.
# A teacher teaches
# and an assistant helps kids with any bathroom emergencies.
# Kids themselves can learn and play.
# A teacher and principle can supervise a class.
# Only the principle has the ability to expel a kid.
# Janitors have the ability to clean.
# Cafeteria workers have the ability to serve food.
# Children, teachers, class assistants, principles, janitors and cafeteria workers all have the ability to eat lunch.

module Chaperonable
  def help_with_schoolwork
    "helps student with schoolworks"
  end

  def chaperone
    "watches the students on the playground"
  end
end

module Supervisable
  def supervise
    "supervises a class"
  end
end

module Eatable
  def eat_lunch
    "eats lunch"
  end
end

class Student
  include Eatable

  def learn
    "learns"
  end

  def play
    "plays"
  end
end

class Staff
  include Eatable
end

class Teacher < Staff
  include Chaperonable
  include Supervisable

  def teach
    "teaches"
  end
end

class Assistant < Staff
  include Chaperonable

  def assist
    "assists children with bathroom emergencies"
  end
end

class Principal < Staff
  include Supervisable

  def initialize(school)
    @school = school
  end

  def expel(student)
    school.expel_student(student)
  end

  private

  attr_reader :school
end

class Janitor < Staff
  def clean
    "cleans"
  end
end

class CafeteriaWorker < Staff
  def serve_food
    "serves food"
  end
end

class Preschool
  def initialize
    @students = []
    @staff = []
  end

  def add_student(*children)
    children.each { |c| students << c }
  end

  def add_staff(*workers)
    workers.each { |w| staff << w }
  end

  def expel_student(student)
    students.delete(student)
  end

  private
  attr_accessor :students, :staff
end

# Testing

preschool = Preschool.new

p student = Student.new
p student2 = Student.new
teacher = Teacher.new
assistant = Assistant.new
principal = Principal.new(preschool)
janitor = Janitor.new
cafeteriaworker = CafeteriaWorker.new

preschool.add_staff(teacher, assistant, principal, janitor, cafeteriaworker)
preschool.add_student(student, student2)
p preschool
principal.expel(student)
p preschool