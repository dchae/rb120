# OO RPS Bonus Features

class Move
  include Comparable
  VALUES = %w[rock paper scissors]

  def initialize(value)
    @value = value
  end

  def beats(other)
    [
      rock? && other.scissors?,
      paper? && other.rock?,
      scissors? && other.paper?,
    ].any?
  end

  def <=>(other)
    if other.value == value
      0
    elsif beats(other)
      1
    else
      -1
    end
  end

  def to_s
    value
  end

  protected

  attr_reader :value

  def scissors?
    value == "scissors"
  end

  def rock?
    value == "rock"
  end

  def paper?
    value == "paper"
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = 0
  end
end

class Human < Player
  def set_name
    name_input = nil
    loop do
      puts "What's your name?"
      name_input = gets.chomp
      break unless name_input.empty?
      puts "Sorry, must enter a value."
    end
    self.name = name_input
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, or scissors:"
      choice = gets.chomp.downcase
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ["R2D2", "Hal", "Chappie", "Sonny", "Number 5"].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end
# Game Orchestration Engine

class RPSGame
  BEATS = { "paper" => "rock", "rock" => "scissors", "scissors" => "paper" }
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Goodbye #{human.name}!"
  end

  def display_choices
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def winner
    if human.move > computer.move
      human
    elsif human.move < computer.move
      computer
    else
      false
    end
  end

  def display_winner(winner)
    case winner
    when human
      puts "#{human.name} won!"
    when computer
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def update_score
    winner.score += 1 if winner
  end

  def display_score
    puts "Score:"
    puts "#{human.name}: #{human.score}, #{computer.name}: #{computer.score}"
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      update_score
      display_choices
      display_winner(winner)
      display_score
      break unless play_again?
    end
    display_goodbye_message
  end

  def play_again?
    answer = nil
    loop do
      puts "Play again? (y/n)"
      answer = gets.chomp.downcase
      break if answer =~ /^(y|n)$/
      puts "Invalid input."
    end
    answer == "y"
  end
end

newgame = RPSGame.new
newgame.play
