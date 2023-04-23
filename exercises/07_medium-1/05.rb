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
    @operations = program.split
    @stack = []
    @register = 0
    create_methods(MATH_OPERATORS)
  end

  def eval
    operations.each { |op| eval_op(op) }
  rescue MinilangProgramError => e
    puts e.message
  end

  private

  attr_accessor :stack, :register

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
    raise EmptyStackError if stack.empty?
    self.register = stack.pop
  end

  def print
    puts register
  end

  def create_methods(hash)
    # create a method for each name, operator pair in given hash
    hash.each do |name, op|
      self
        .class
        .define_method(name) do
          self.register = self.register.send(op, self.pop)
        end
    end
    # make these methods private
    self.class.send :private, MATH_OPERATORS.keys
  end
end

Minilang.new("PRINT").eval
# 0

Minilang.new("5 PUSH 3 MULT PRINT").eval
# 15

Minilang.new("5 PRINT PUSH 3 PRINT ADD PRINT").eval
# 5
# 3
# 8

Minilang.new("5 PUSH 10 PRINT POP PRINT").eval
# 10
# 5

Minilang.new("5 PUSH POP POP PRINT").eval
# Empty stack!

Minilang.new("3 PUSH PUSH 7 DIV MULT PRINT ").eval
# 6

Minilang.new("4 PUSH PUSH 7 MOD MULT PRINT ").eval
# 12

Minilang.new("-3 PUSH 5 XSUB PRINT").eval
# Invalid token: XSUB

Minilang.new("-3 PUSH 5 SUB PRINT").eval
# 8

Minilang.new("6 PUSH").eval
# (nothing printed; no PRINT commands)
