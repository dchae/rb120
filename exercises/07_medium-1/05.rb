class EmptyStackError < ArgumentError
  def initialize(msg = "Required value not on stack (stack empty)")
    super(msg)
  end
end

class Minilang
  MATH_OPERATORS = {
    "ADD" => :+,
    "SUB" => :-,
    "MULT" => :*,
    "DIV" => :/,
    "MOD" => :%,
  }

  attr_reader :operations

  def initialize(program)
    @operations = program.split
    @stack = []
    @register = 0
  end

  def eval
    operations.each do |op|
      case op
      when /\d/
        self.register = op.to_i
      when "PUSH"
        stack << register
      when "POP"
        raise EmptyStackError if stack.empty?
        self.register = stack.pop
      when "PRINT"
        puts register
      else
        if !MATH_OPERATORS.key?(op)
          raise ArgumentError.new "Invalid operation in program: '#{op}'"
        elsif stack.empty?
          raise EmptyStackError
        end

        self.register = register.send(MATH_OPERATORS[op], stack.pop)
      end
    end
  end

  private

  attr_accessor :stack, :register
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

begin
Minilang.new("5 PUSH POP POP PRINT").eval
rescue => e
  puts e.message
end
# Empty stack!

Minilang.new("3 PUSH PUSH 7 DIV MULT PRINT ").eval
# 6

Minilang.new("4 PUSH PUSH 7 MOD MULT PRINT ").eval
# 12

begin
Minilang.new("-3 PUSH 5 XSUB PRINT").eval
rescue => e
  puts e.message
end
# Invalid token: XSUB

Minilang.new("-3 PUSH 5 SUB PRINT").eval
# 8

Minilang.new("6 PUSH").eval
# (nothing printed; no PRINT commands)
