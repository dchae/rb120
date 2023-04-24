class GuessingGame
  def initialize(low = 1, high = 100)
    @answer_range = (low..high)
    @initial_attempts = Math.log2(answer_range.size).to_i + 1
  end

  def play
    init
    main_loop
    display_result
  end

  private

  attr_reader :answer_range, :initial_attempts
  attr_accessor :guesses_remaining, :guess, :answer

  def init
    self.guesses_remaining = initial_attempts
    self.answer = rand(answer_range)
    self.guess = nil
  end

  def main_loop
    while guesses_remaining > 0 && guess != answer
      display_guesses_remaining

      self.guess = player_guess

      display_feedback
      decrement_guesses_remaining
    end
  end

  def display_guesses_remaining
    puts "You have #{guesses_remaining} guesses remaining."
  end

  def player_guess
    choice = nil
    loop do
      print "Enter a number between #{answer_range.first} and #{answer_range.last}: "
      choice = gets.chomp
      break if choice =~ /^[0-9]+$/ && answer_range === choice.to_i
      print "Invalid guess. "
    end
    choice.to_i
  end

  def display_feedback
    feedback = [
      "That's the number!",
      "Your guess is too high.",
      "Your guess is too low.",
    ]
    puts feedback[guess <=> answer]
  end

  def decrement_guesses_remaining
    self.guesses_remaining -= 1
  end

  def display_result
    puts guess == answer ? "You won!" : "You have no more guesses. You lost!"
  end
end

game = GuessingGame.new(501, 1500)
game.play
