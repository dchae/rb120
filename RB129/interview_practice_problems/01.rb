# Problem by Natalie Thompson
# Add 1 line of code for the person class
# and 1 line of code in the initialize method. 

#Other than that don't change Person.

class Person
  def initialize(name, job)
      @name = name
      @job = job
  end 

  def to_s; "My name is #{@name} and I am a #{@job}"; end
end

roger = Person.new("Roger", "Carpenter")
puts roger


# Output:
# "My name is Roger and I am a Carpenter"