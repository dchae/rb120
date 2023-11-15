class Human # Problem received from Raul Romero
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def equal?(other)
    self.name == other.name
  end

  def +(other, b = BINDING)
    a = eval("local_variables.select { |v| eval(v.to_s + '.object_id') == #{self.object_id.to_s}}", b)
    b = eval("local_variables.select { |v| eval(v.to_s + '.object_id') == #{other.object_id.to_s}}", b)
    [a, b].join
  end
end

BINDING = binding
gilles = Human.new('gilles')
anna = Human.new('gilles')

puts anna.equal?(gilles) #should output true 
puts anna + gilles # should output annagilles