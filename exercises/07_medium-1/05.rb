class MinilangProgramError < StandardError
end
class InvalidOperationError < MinilangProgramError
  def initialize(op = nil, msg = "Invalid operation in program")
    @op = op
    super(msg + (op ? ": #{op}" : ""))
  end
end
class EmptyStackError < MinilangProgramError
  def initialize(msg = "Required value not on stack (stack empty)")
    super(msg)
  end
end
class Minilang
  MATH_OPERATORS = { add: :+, sub: :-, mult: :*, div: :/, mod: :% }

  attr_reader :operations

  def initialize(program)
    @program = program
    create_methods(MATH_OPERATORS)
  end

  def eval(*args)
    @stack = []
    @register = 0
    @operations = format(program, *args).split
    operations.each { |op| eval_op(op) }
  rescue MinilangProgramError => e
    puts e.message
  end

  private

  attr_accessor :program, :stack, :register

  def eval_op(op)
    if op =~ /\d/
      self.register = op.to_i
    elsif self.class.private_method_defined?((op_sym = op.downcase.to_sym))
      self.send(op_sym)
    else
      raise InvalidOperationError, op
    end
  end

  def push
    stack << register
  end

  def pop
    self.register = stack_pop
  end

  def print
    puts register
  end

  # separated pop from stack from miniland operation "POP"
  def stack_pop
    raise EmptyStackError if stack.empty?
    stack.pop
  end

  def create_methods(hash)
    # create a method for each name, operator pair in given hash
    hash.each do |name, op|
      self
        .class
        .define_method(name) do
          self.register = self.register.send(op, self.stack_pop)
        end
    end
    # make these methods private
    self.class.send :private, MATH_OPERATORS.keys
  end
end

Minilang.new("PRINT").eval # => 0

Minilang.new("5 PUSH 3 MULT PRINT").eval # => 15

Minilang.new("5 PRINT PUSH 3 PRINT ADD PRINT").eval
# => 5
# => 3
# => 8

Minilang.new("5 PUSH 10 PRINT POP PRINT").eval
# => 10
# => 5

Minilang.new("5 PUSH POP POP PRINT").eval # => Empty stack!

Minilang.new("3 PUSH PUSH 7 DIV MULT PRINT ").eval # => 6

Minilang.new("4 PUSH PUSH 7 MOD MULT PRINT ").eval # => 12

Minilang.new("-3 PUSH 5 XSUB PRINT").eval # => Invalid token: XSUB

Minilang.new("-3 PUSH 5 SUB PRINT").eval # => 8

Minilang.new("6 PUSH").eval # => (nothing printed; no PRINT commands)

CENTIGRADE_TO_FAHRENHEIT =
  "5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT"
minilang = Minilang.new(CENTIGRADE_TO_FAHRENHEIT)
minilang.eval(degrees_c: 100) # => 212
minilang.eval(degrees_c: 0)   # => 32
minilang.eval(degrees_c: -40) # => -40

AREA_OF_RECTANGLE = "%<width>d PUSH %<length>d MULT PRINT"
minilang = Minilang.new(AREA_OF_RECTANGLE)
minilang.eval(width: 4, length: 3) # => 12
minilang.eval(width: 0, length: 9) # => 0
minilang.eval(width: 7, length: 5) # => 35
