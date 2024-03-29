# OO RPS Bonus Features
# - Added Lizard, Spock
# - Adding move history

class Move
  include Comparable
  VALUES = {
    rock: %i[scissors lizard],
    paper: %i[rock spock],
    scissors: %i[paper lizard],
    lizard: %i[paper spock],
    spock: %i[rock scissors],
  }

  def initialize(value)
    @value = value.to_sym
  end

  def beats(other)
    VALUES[value].include?(other.value)
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
    value.to_s
  end

  protected

  attr_reader :value

  def scissors?
    value == :scissors
  end

  def rock?
    value == :rock
  end

  def paper?
    value == :paper
  end

  def lizard?
    value == :lizard
  end

  def spock?
    value == :spock
  end
end

class Player
  attr_accessor :move, :name, :score, :move_history

  def initialize
    set_name
    @score = 0
    @move_history = []
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
      puts "Please choose rock, paper, scissors, lizard, or spock:"
      choice = gets.chomp.downcase
      break if Move::VALUES.include?(choice.to_sym)
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
    self.move_history << self.move
  end
end

class Computer < Player
  COMPUTER_NAMES = ["R2D2", "Hal", "Chappie", "Sonny", "Number 5"]
  WEIGHTS =
    COMPUTER_NAMES.zip(
      [
        [1.0, 0, 0, 0, 0],
        [0.1, 0.0, 0.6, 0.15, 0.15],
        [0.2, 0.2, 0.2, 0.2, 0.2],
        [0.1, 0.15, 0.05, 0.4, 0.3],
        [0.05, 0.05, 0.05, 0.05, 0.8],
      ],
    ).to_h

  def initialize
    super
    moves = Move::VALUES.keys
    zipped_moves_and_weights = moves.zip(WEIGHTS[self.name])
    @weighted_moves = zipped_moves_and_weights.to_h
  end

  def set_name
    self.name = COMPUTER_NAMES.sample
  end

  def choose
    chosen_move =
      weighted_moves.max_by { |_, weight| rand**(1.0 / weight) }.first
    self.move = Move.new(chosen_move)
    self.move_history << self.move
  end

  private

  attr_reader :weighted_moves
end
# Game Orchestration Engine

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Lizard, Spock. Goodbye #{human.name}!"
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

  def display_move_history
    puts "Move History:"
    human
      .move_history
      .zip(computer.move_history)
      .each_with_index do |(human_move, computer_move), i|
        puts "Round #{i + 1}: #{human.name} played #{human_move}, #{computer.name} played #{computer_move}."
      end
  end

  def display_opponent
    puts "Your opponent is #{computer.name}."
  end

  def display_score
    puts "Score:"
    puts "#{human.name}: #{human.score}, #{computer.name}: #{computer.score}"
  end

  def play
    display_welcome_message
    display_opponent
    loop do
      human.choose
      computer.choose
      update_score
      display_choices
      display_winner(winner)
      display_score
      break unless play_again?
    end
    display_move_history
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
