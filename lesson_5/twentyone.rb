class Player
  attr_reader :name, :cards

  def initialize(name)
    @name = name
    @cards = []
  end

  def reset_cards
    cards.clear
  end

  def busted?
    total > 21
  end

  def total
    total = cards.sum(&:value)
    cards.count(&:ace?).times { |_| total += 10 if total < 11 }
    total
  end

  def add_to_hand(card)
    cards << card
  end

  def display_hand(hidden_cards: 0)
    hand =
      cards
      .size
      .times
      .map do |i|
        i < (cards.size - hidden_cards) ? cards[i].to_s : "[HIDDEN CARD]"
      end
      .join(", ")
    puts hand
  end
end

class Dealer < Player
  def initialize
    super("Dealer")
  end
end

class Deck
  attr_reader :cards

  def initialize
    @cards = Card::NUMBERS.map { |x| Card.new(x) }.flatten
  end

  def draw_card
    cards.delete_at(rand(cards.size))
  end

  def deal_to(player)
    player.add_to_hand(draw_card)
  end

  private

  attr_writer :cards
end

class Card
  NUMBERS = (0...52)
  SUITS = %w[Clubs Diamonds Hearts Spades]
  RANKS = %w[Ace Two Three Four Five Six Seven Eight Nine Ten Jack Queen King]
  attr_reader :rank, :suit

  def initialize(ord)
    if !NUMBERS.include?(ord)
      raise(ArgumentError,
            "expected card number within range (0..52)")
    end
    @suit = ord / 13
    @rank = ord % 13
    @value = value
  end

  def ace?
    rank == 0
  end

  def value
    [rank + 1, 10].min
  end

  def to_s
    "#{RANKS[rank]} of #{SUITS[suit]}"
  end
end

class Game
  attr_reader :deck, :dealer, :player

  def initialize
    @deck = Deck.new
    @dealer = Dealer.new
    @player = Player.new(player_name)
  end

  def start
    clear_screen
    greet_player
    game_loop
    goodbye_message
  end

  private

  def prompt(str)
    puts "=> #{str}"
    nil
  end

  def game_loop
    loop do
      initial_deal
      show_cards
      player_turn
      dealer_turn if !player.busted?
      show_result
      break if !play_again?
      reset_game
      play_again_message
    end
  end

  def clear_screen
    system "clear"
  end

  def player_continue
    prompt "Press enter to continue.."
    gets
  end

  def greet_player
    puts "Hello, #{player.name}. Welcome to Twenty-One!"
  end

  def goodbye_message
    puts "Goodbye, #{player.name}. Thanks for playing Twenty-One!"
  end

  def play_again_message
    puts "You chose to play again!\n\n"
  end

  def player_name
    name = nil
    loop do
      prompt "What's your name?"
      name = gets.chomp
      break if name =~ /[^\s]/
      puts "Not a valid name."
    end
    name
  end

  def initial_deal
    [player, dealer].each do |new_owner|
      2.times { |_| deck.deal_to(new_owner) }
    end
  end

  def show_cards(is_player_turn: true)
    puts
    puts "#{dealer.name}'s hand: "
    dealer.display_hand(hidden_cards: is_player_turn ? 1 : 0)
    puts "Value: #{is_player_turn ? 'HIDDEN' : dealer.total}"
    puts "#{player.name}'s hand: "
    player.display_hand
    puts "Value: #{player.total}\n\n"
  end

  def player_choice
    loop do
      prompt "Would you like to hit or stay? (h/s)"
      choice = gets.chomp.downcase
      return choice if choice =~ /^[hs]$/
      puts "Not a valid choice."
    end
  end

  def player_hit
    deck.deal_to(player)
    puts "You chose to hit.\nYou drew the #{player.cards.last}\n"
  end

  def player_turn
    puts "#{player.name}'s turn..."
    while player_choice != "s"
      player_hit

      if player.busted?
        puts "You busted!"
        return
      end

      show_cards
    end
    puts "You chose to stay."
  end

  def dealer_turn
    puts "\nDealer's turn..."
    dealer_loop
    puts(dealer.busted? ? "#{dealer.name} busted!" : "Dealer stays!")
  end

  def dealer_loop
    while dealer.total < 17
      player_continue
      deck.deal_to(dealer)
      puts "#{dealer.name} drew the #{dealer.cards.last}"
    end
  end

  def show_result
    puts
    show_cards(is_player_turn: false)
    show_winner
  end

  def show_winner
    players = [player, dealer].sort_by(&:total)
    winner = players.last
    if players.any?(&:busted?)
      winner = players.first
    elsif player.total == dealer.total
      puts "It's a tie!"
      return
    end
    puts "#{winner.name} wins!"
  end

  def validate_choice
    # to implement
  end

  def play_again?
    choice = nil
    loop do
      prompt "Would you like to play again? (y/n)"
      choice = gets.chomp.downcase
      break if choice =~ /^[yn]$/
      puts "Not a valid choice"
    end
    choice == "y"
  end

  def reset_game
    @deck = Deck.new
    [player, dealer].each(&:reset_cards)
    clear_screen
  end
end

Game.new.start
