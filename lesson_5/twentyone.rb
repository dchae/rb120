require "pry"

class Player
  attr_reader

  def initialize(name)
    @name = name
  end

  def hit
  end

  def stay
  end

  def busted?
  end

  def total
    cards
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

  def deal(new_owner)
    cards.reject(&:owner).sample.owner = new_owner
  end
end

class Card
  attr_reader :value, :suit
  attr_accessor :owner

  def initialize(value, suit)
    @value = value
    @suit = suit
    @owner = nil
  end
end

class Game
  attr_reader :deck, :dealer, :player

  def initialize
    @deck = Deck.new
    @dealer = Dealer.new
    @player = Player.new(get_player_name)
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
    [player, dealer].each { |new_owner| 2.times { |_| deck.deal(new_owner) }}
  end

  def start
    initial_deal
    binding.pry
    # show_initial_cards
    # player_turn
    # dealer_turn
    # show_result
  end
end

Game.new.start
