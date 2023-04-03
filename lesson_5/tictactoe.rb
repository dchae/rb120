class Board
  INITIAL_MARKER = " "
  attr_reader :squares

  def initialize
    @squares = Hash[(1..9).map { |k| [k, Square.new(INITIAL_MARKER)] }]
  end

  def get_square_at(key)
    squares[key]
  end
end

class Square
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end

  def to_s
    marker
  end
end

class Player
  def initialize
  end

  def mark
  end
end

class TTTGame
  CELL_WIDTH = 7
  CELL_HEIGHT = 3
  HORIZONTAL_SEPARATOR = "#{["-" * CELL_WIDTH] * 3 * "+"}\n"
  HORIZONTAL_SPACER = "#{[" " * CELL_WIDTH] * 3 * "|"}\n"

  attr_reader :board

  def initialize
    @board = Board.new
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_board
    board_string =
      (1..3)
        .map do |row|
          HORIZONTAL_SPACER * (CELL_HEIGHT / 2) +
            (1..3)
              .map do |col|
                board.get_square_at(row + col).to_s.center(CELL_WIDTH)
              end
              .join("|") + "\n" + HORIZONTAL_SPACER * (CELL_HEIGHT / 2)
        end
        .join(HORIZONTAL_SEPARATOR)
    puts board_string + "\n"
  end

  def display_result
  end

  def play
    display_welcome_message
    loop do
      display_board
      break
      first_player_moves
      break if someone_won? || board_full?

      second_player_moves
      break if someone_won? || board_full?
    end
    display_result
    display_goodbye_message
  end
end

game = TTTGame.new
game.play
