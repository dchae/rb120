# OO RPS Design Choice 1

class Player
  attr_accessor :move, :name

  def initialize
    set_name
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
      break if %W[rock paper scissors].include?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = choice
  end
end

class Computer < Player
  def set_name
    self.name = ["R2D2", "Hal", "Chappie", "Sonny", "Number 5"].sample
  end

  def choose
    self.move = %W[rock paper scissors].sample
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

  def display_winner
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
    if BEATS.any? { |winning, losing|
         [human.move, computer.move] == [winning, losing]
       }
      puts "#{human.name} wins!"
    elsif BEATS.any? do |winning, losing|
          [computer.move, human.move] == [winning, losing]
        end
      puts "#{computer.name} wins!"
    else
      puts "It's a tie"
    end
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_winner
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

# I think this design is better.
# Adding the Human and Computer sub-classes to replace the previous conditional logic
# feels like it will make the program easier to modify and debug if/when it gets bigger.

# Primary improvement - objects in our code better represent objects in the game
#                     - less specific conditionals => more modular code

# Primary drawback - more verbose? May be overbuilding, since we know this code can only get so complex (RPS).
