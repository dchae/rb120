require "pry"

class Player
  attr_reader :name, :cards

  def initialize(name)
    @name = name
    @cards = []
  end

  def busted?
    total > 21
  end

  def total
    total = cards.sum(&:value)
    cards.count(&:ace?).times { |_| total += 10 if total < 21 }
    total
  end

  def add_to_hand(card)
    cards << card
  end

  def display_hand(hidden_cards: 0)
    puts cards
           .size
           .times
           .map { |i|
             i < (cards.size - hidden_cards) ? cards[i].to_s : "[HIDDEN CARD]"
           }
           .join(", ")
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
    @cards =
      %W[Clubs Diamonds Hearts Spades]
        .map { |suit| (1..13).map { |val| Card.new(val, suit) } }
        .flatten
  end

  def draw_card
    cards.delete_at(rand(cards.size))
  end

  def deal_to(player)
    player.add_to_hand(draw_card)
  end
end

class Card
  RANKS = %W[Ace Two Three Four Five Six Seven Eight Nine Ten Jack Queen King]
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    @value = value
  end

  def ace?
    rank == 1
  end

  def value
    [rank, 10].min
  end

  def to_s
    "#{RANKS[rank - 1]} of #{suit}"
  end
end

class Game
  attr_reader :deck, :dealer, :player

  def initialize
    @deck = Deck.new
    @dealer = Dealer.new
    @player = Player.new(get_player_name)
  end

  def start
    greet_player
    initial_deal
    show_cards
    player_turn
    dealer_turn if !player.busted?
    show_result
    # binding.pry
  end

  private

  def greet_player
    puts "Hello, #{player.name}. Welcome to Twenty-One!"
    puts
  end

  def get_player_name
    name = nil
    loop do
      puts "What's your name?"
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

  def show_cards(player_turn: true)
    puts "#{dealer.name}'s hand: "
    dealer.display_hand(hidden_cards: player_turn ? 1 : 0)
    puts "Value: #{player_turn ? "HIDDEN" : dealer.total}"
    puts "#{player.name}'s hand: "
    player.display_hand
    puts "Value: #{player.total}\n\n"
  end

  def player_turn
    loop do
      choice = nil
      loop do
        puts "Would you like to hit or stay? (h/s)"
        choice = gets.chomp.downcase
        break if choice =~ /[hs]{1}/
        puts "Not a valid choice."
      end

      if choice == "s"
        puts "You chose to stay."
        break
      end

      puts "You chose to hit."
      deck.deal_to(player)
      puts "You drew the #{player.cards.last}"
      puts
      break if player.busted?
      show_cards
    end
  end

  def dealer_turn
    puts
    while !dealer.busted? && dealer.total < 17
      deck.deal_to(dealer)
      puts "#{dealer.name} drew the #{dealer.cards.last}"
    end
  end

  def show_result
    puts
    show_cards(player_turn: false)
    if player.busted?
      puts "#{player.name} busted! #{dealer.name} wins."
    elsif dealer.busted?
      puts "#{dealer.name} busted. #{player.name} wins!"
    elsif player.total > dealer.total
      puts "#{player.name} wins!"
    else
      puts "#{dealer.name} wins."
    end
  end
end

Game.new.start
