class GuessingGame
  def play
    guesses_remaining = 7
    answer = rand(1..100)
    guess = nil

    while guesses_remaining > 0 && guess != answer
      puts "You have #{guesses_remaining} guesses remaining."

      choice = nil
      loop do
        print "Enter a number between 1 and 100: "
        choice = gets.chomp
        break if choice =~ /^[0-9]+$/ && (1..100).include?(choice.to_i)
        print "Invalid guess. "
      end
      guess = choice.to_i

      puts [
             "That's the number!",
             "Your guess is too high.",
             "Your guess is too low.",
           ][
             guess <=> answer
           ]

      guesses_remaining -= 1
    end
    puts guess == answer ? "You won!" : "You have no more guesses. You lost!"
  end
end

game = GuessingGame.new
game.play
