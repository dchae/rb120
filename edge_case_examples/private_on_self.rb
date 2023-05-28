class Foo
  def self.method_a
    "Justice" + all
  end

  def self.method_b(other)
    "Justice" + other.exclamate
  end

  private

  def self.all
    " for all"
  end

  def self.exclamate
    all + "!!!"
  end
end

# foo = Foo.new
# puts Foo.method_a
# puts Foo.method_b(Foo)

# What will the last two lines return?

class Foo
  def method_a
    "Justice" + all
  end

  def method_b(other)
    "Justice" + other.exclamate
    # "Justice" + other.send(:exclamate)
  end

  self.private

  def all
    " for all"
  end

  def exclamate
    all + "!!!"
  end
end

foo = Foo.new
puts foo.method_a
puts foo.method_b(foo)

# What will the last two lines return?
