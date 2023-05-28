class Foo
  def initialize(name)
    @name = name
  end

  def ==(other)
    name == other.name
  end

  protected

  attr_reader :name
end

class Bar < Foo
end


foo = Foo.new("a")
bar = Bar.new("a")

p foo == bar
p bar == foo