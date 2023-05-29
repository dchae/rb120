class Foo
  @@var = 1

  def self.var
    @@var
  end
end

class Bar < Foo
  @@var = 2
end

puts Foo.var 
puts Bar.var 