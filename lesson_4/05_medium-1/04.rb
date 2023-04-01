class Greeting
  def greet(s)
    puts s
  end
end

class Hello < Greeting
  def hi
    greet "Hello"
  end
end

class Goodbye < Greeting
  def bye
    greet "Goodbye"
  end
end

a = Hello.new
a.hi

b = Goodbye.new
b.bye
