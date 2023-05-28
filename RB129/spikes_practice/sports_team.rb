# Design a Sports Team (Author Unknown...thank you!)
# 
# - Include 4 players (attacker, midfielder, defender, goalkeeper)
# - All the players’ jersey is blue, except the goalkeeper, his jersey is white with blue stripes
# - All players can run and shoot the ball.
# - Attacker should be able to lob the ball
# - Midfielder should be able to pass the ball
# - Defender should be able to block the ball
# - The referee has a whistle. He wears black and is able to run and whistle.

module Runnable
  def run
    "runs"
  end
end

class Whistle
  def blow
    "PEEEEEEP!"
  end
end

class SportsPerson
  include Runnable

  def initialize(jersey_colour)
    @jersey_colour = jersey_colour
  end
end

class Referee < SportsPerson
  attr_reader :whistle

  def initialize(jersey_colour = "black")
    super(jersey_colour)
    @whistle = Whistle.new
  end

  def blow_whistle
    whistle.blow
  end
end

class Player < SportsPerson
  def initialize(jersey_colour = "blue")
    super(jersey_colour)
  end

  def shoot
    "shoots the ball"
  end
end

class Attacker < Player
  def lob
    "lobs the ball"
  end
end

class Midfielder < Player
  def pass
    "pass the ball"
  end
end

class Defender < Player
  def block
    "block the ball"
  end
end

class Goalkeeper < Player
  def initialize(jersey_colour = "white with blue stripes")
    super(jersey_colour)
  end
end

class Team
  def initialize(*members)
    @members = members
  end
end

a = Attacker.new
b = Midfielder.new
c = Defender.new
d = Goalkeeper.new
e = Referee.new

team = Team.new(a, b, c, d)
p team
p e
p e.blow_whistle