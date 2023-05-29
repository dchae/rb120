STR = "Main"

module Walk
  # STR = "Walking"
end

module Run
  # STR = "Running"
end

module Jump
  # STR = "Jumping"
end

class Bunny
  include Jump
  include Walk
  include Run
end

class Bugs < Bunny
  def self.str
    STR
  end

  def str
    STR
  end
end

p Bugs.ancestors
# p Bugs::STR
p Bugs.str
p Bugs.new.str