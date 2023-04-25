class Card
  include Comparable
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    @value = card_value(rank)
  end

  def <=>(other)
    value <=> other.value
  end

  def to_s
    "#{rank} of #{suit}"
  end

  protected

  attr_reader :value

  private

  def card_value(rank)
    if rank.is_a? Integer
      value = (rank - 2) * 4
    else
      value = ("JQKA".index(rank[0]) + 9) * 4
    end
    value + "DCHS".index(suit[0])
  end
end

class Deck
  RANKS = ((2..10).to_a + %w[Jack Queen King Ace]).freeze
  SUITS = %w[Hearts Clubs Diamonds Spades].freeze

  def initialize
    @cards = new_deck
    shuffle
  end

  def draw
    self.cards = new_deck if cards.empty?
    cards.pop
  end

  def shuffle
    cards.shuffle!
  end

  private

  attr_accessor :cards

  def new_deck
    RANKS.map { |r| SUITS.map { |s| Card.new(r, s) } }.flatten
  end
end

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
p drawn.count { |card| card.rank == 5 } == 4
p drawn.count { |card| card.suit == "Hearts" } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2 # Almost always.
