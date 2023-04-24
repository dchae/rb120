class GuessingGame
  INITIAL_ATTEMPTS = 7
  ANSWER_RANGE = 1..100

  def play
    init
    main_loop
    display_result
  end

  private

  attr_accessor :guesses_remaining, :guess, :answer

  def init
    self.guesses_remaining = INITIAL_ATTEMPTS
    self.answer = rand(ANSWER_RANGE)
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
      print "Enter a number between 1 and 100: "
      choice = gets.chomp
      break if choice =~ /^[0-9]+$/ && ANSWER_RANGE === choice.to_i
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

game = GuessingGame.new
game.play
