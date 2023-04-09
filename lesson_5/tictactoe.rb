require "pry"

class Board
  WINNING_LINES =
    [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
      [[1, 5, 9], [3, 5, 7]]
  CELL_WIDTH = 7
  CELL_HEIGHT = 3
  HORIZONTAL_SEPARATOR = "#{["-" * CELL_WIDTH] * 3 * "+"}\n"
  HORIZONTAL_SPACER = "#{[" " * CELL_WIDTH] * 3 * "|"}\n"

  attr_reader :squares

  def initialize
    @squares = Hash[(1..9).map { |k| [k, Square.new] }]
  end

  def reset
    squares.each { |k, _| squares[k] = Square.new }
  end

  def []=(key, marker)
    squares[key].marker = marker
  end

  def unmarked_keys
    squares.keys.select { |k| squares[k].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_line?(squares_in_line)
    marked_squares = squares_in_line.reject { |x| x.unmarked? }
    marked_squares.size == 3 &&
      marked_squares.map { |x| x.marker }.uniq.size == 1
  end

  def winning_marker
    # returns winning marker or nil
    WINNING_LINES.each do |line|
      squares_in_line = line.map { |i| squares[i] }
      return squares_in_line.first.marker if winning_line?(squares_in_line)
    end
    nil
  end

  def draw
    board_string =
      (0..2)
        .map do |row|
          HORIZONTAL_SPACER * (CELL_HEIGHT / 2) +
            (0..2)
              .map { |col| squares[row * 3 + col + 1].to_s.center(CELL_WIDTH) }
              .join("|") + "\n" + HORIZONTAL_SPACER * (CELL_HEIGHT / 2)
        end
        .join(HORIZONTAL_SEPARATOR)
    puts board_string
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

class TTTGame
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_board
    puts "You're a #{human.marker}. Computer is a #{computer.marker}."
    puts
    board.draw
    puts
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def human_moves
    puts "Choose a square: #{board.unmarked_keys.join(", ")}:"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end
    board[square] = human.marker
  end

  def computer_moves
    board[board.unmarked_keys.sample] = computer.marker
  end

  def clear
    system "clear"
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      puts "You won!"
    when computer.marker
      puts "Computer won!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if answer =~ /^[yn]$/
      puts "Sorry, not a valid choice."
    end
    answer == "y"
  end

  def reset
    board.reset
    clear
    puts "Let's play again!"
    puts
  end

  def play
    clear
    display_welcome_message

    loop do
      display_board

      loop do
        human_moves
        break if board.someone_won? || board.full?

        computer_moves
        break if board.someone_won? || board.full?
        clear_screen_and_display_board
      end
      display_result
      break unless play_again?
      reset
    end

    display_goodbye_message
  end
end

game = TTTGame.new
game.play

# test commit addition
