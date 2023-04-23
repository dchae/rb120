CENTIGRADE_TO_FAHRENHEIT =
  "5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT"
PROGRAM = CENTIGRADE_TO_FAHRENHEIT
def some_method(*args)
  puts format(PROGRAM, *args)
end

some_method(degrees_c: 100)
