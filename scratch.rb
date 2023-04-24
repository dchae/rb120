class EmptyStack < StandardError; end

class Minilang
  attr_accessor :stack, :register

  def initialize(string_commands)
    @commands = string_commands
    @stack = []
    @register = 0
  end

  def eval(**missing_data)
    @commands = format(@commands, missing_data).split
    @commands.each do |input|
      command = input.downcase

      if valid_integer?(input)
        load_register(input.to_i)
      elsif self.methods.include?(command.to_sym)
        begin
          send(command)
        rescue EmptyStack
          puts "Empty Stack!"
          break
        end
      else
        puts "#{input} is not a valid command. Process aborted."
        break
      end
    end
  end

  protected

  def load_register(value)
    self.register = value
  end

  def push
    stack << register
  end

  def add
    begin
      self.register += stack.pop
    rescue NoMethodError
      raise EmptyStack
    end

  end

  def sub
    begin
      self.register -= stack.pop
    rescue NoMethodError
      raise EmptyStack
    end

  end

  def mult
    begin
      self.register *= stack.pop
    rescue NoMethodError
      raise EmptyStack
    end

  end

  def div
    begin
      self.register /= stack.pop
    rescue NoMethodError
      raise EmptyStack
    end

  end

  def mod
    begin
      self.register %= stack.pop
    rescue NoMethodError
      raise EmptyStack
    end

  end

  def pop
    self.register = stack.pop
    raise EmptyStack if register == nil
  end

  def print
    puts register
  end

  def valid_integer?(number)
    number.to_i.to_s == number
  end
end

FARENHEIT_TO_CENTRIGADE =
  '9 PUSH 32 PUSH %<degrees_f>d SUB PUSH 5 MULT DIV PRINT'

CENTIGRADE_TO_FAHRENHEIT =
  '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'

AREA_RECTANGLE =
  '%<width>d PUSH %<length>d MULT PRINT'

temp1 = Minilang.new(FARENHEIT_TO_CENTRIGADE)
temp1.eval(degrees_f: 68)
# 20

temp2 = Minilang.new(CENTIGRADE_TO_FAHRENHEIT)
temp2.eval(degrees_c: 30)
# 86

minilang = Minilang.new(AREA_RECTANGLE)
minilang.eval(width: 10, length: 5)
# 50