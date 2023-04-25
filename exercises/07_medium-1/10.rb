class Card
  include Comparable

  attr_reader :rank, :suit, :value

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

  private

  def card_value(rank)
    if rank.is_a? Integer
      card_value = (rank - 2)
    else
      card_value = ("JQKA".index(rank[0]) + 9)
    end
    [card_value, "HCDS".index(suit[0])]
  end
end

class Deck
  RANKS = ((2..10).to_a + %w[Jack Queen King Ace]).freeze
  SUITS = %w[Hearts Clubs Diamonds Spades].freeze

  attr_reader :cards

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

  def to_s
    cards.map(&:to_s).to_s
  end

  private

  attr_writer :cards

  def new_deck
    RANKS.map { |r| SUITS.map { |s| Card.new(r, s) } }.flatten
  end
end

class PokerHand
  def initialize(hand)
    @cards = 5.times.map { |_| hand.draw }
    @values = cards.sort.map(&:value)
    @rank_values = values.map(&:first)
    @rank_tally = rank_values.tally
    @suit_values = values.map(&:last)
  end

  def print
    puts cards
  end

  def evaluate
    case
    when royal_flush?
      "Royal flush"
    when straight_flush?
      "Straight flush"
    when four_of_a_kind?
      "Four of a kind"
    when full_house?
      "Full house"
    when flush?
      "Flush"
    when straight?
      "Straight"
    when three_of_a_kind?
      "Three of a kind"
    when two_pair?
      "Two pair"
    when pair?
      "Pair"
    else
      "High card"
    end
  end

  private

  attr_accessor :cards, :values, :rank_values, :rank_tally, :suit_values

  def royal_flush?
    rank_values == (8..12).to_a && flush?
  end

  def straight_flush?
    straight? && flush?
  end

  def four_of_a_kind?
    rank_tally.any? { |k, v| v > 3 }
  end

  def full_house?
    rank_tally.map(&:last).sort == [2, 3]
  end

  def flush?
    suit_values.uniq.size == 1
  end

  def straight?
    return true if rank_values.reject { |x| x == 12 }.sort == (0..3).to_a
    rank_values == Range.new(*rank_values.values_at(0, -1)).to_a
  end

  def three_of_a_kind?
    rank_tally.any? { |k, v| v > 2 }
  end

  def two_pair?
    rank_tally.select { |k, v| v > 1 }.size > 1
  end

  def pair?
    rank_tally.any? { |k, v| v > 1 }
  end
end

hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
hand =
  PokerHand.new(
    [
      Card.new(10, "Hearts"),
      Card.new("Ace", "Hearts"),
      Card.new("Queen", "Hearts"),
      Card.new("King", "Hearts"),
      Card.new("Jack", "Hearts"),
    ],
  )
puts hand.evaluate == "Royal flush"

hand =
  PokerHand.new(
    [
      Card.new(8, "Clubs"),
      Card.new(9, "Clubs"),
      Card.new("Queen", "Clubs"),
      Card.new(10, "Clubs"),
      Card.new("Jack", "Clubs"),
    ],
  )
puts hand.evaluate == "Straight flush"

hand =
  PokerHand.new(
    [
      Card.new("Ace", "Clubs"),
      Card.new(2, "Clubs"),
      Card.new(3, "Clubs"),
      Card.new(4, "Clubs"),
      Card.new(5, "Clubs"),
    ],
  )
puts hand.evaluate == "Straight flush"

hand =
  PokerHand.new(
    [
      Card.new(3, "Hearts"),
      Card.new(3, "Clubs"),
      Card.new(5, "Diamonds"),
      Card.new(3, "Spades"),
      Card.new(3, "Diamonds"),
    ],
  )
puts hand.evaluate == "Four of a kind"

hand =
  PokerHand.new(
    [
      Card.new(3, "Hearts"),
      Card.new(3, "Clubs"),
      Card.new(5, "Diamonds"),
      Card.new(3, "Spades"),
      Card.new(5, "Hearts"),
    ],
  )
puts hand.evaluate == "Full house"

hand =
  PokerHand.new(
    [
      Card.new(10, "Hearts"),
      Card.new("Ace", "Hearts"),
      Card.new(2, "Hearts"),
      Card.new("King", "Hearts"),
      Card.new(3, "Hearts"),
    ],
  )
puts hand.evaluate == "Flush"

hand =
  PokerHand.new(
    [
      Card.new(8, "Clubs"),
      Card.new(9, "Diamonds"),
      Card.new(10, "Clubs"),
      Card.new(7, "Hearts"),
      Card.new("Jack", "Clubs"),
    ],
  )
puts hand.evaluate == "Straight"

hand =
  PokerHand.new(
    [
      Card.new(2, "Clubs"),
      Card.new(3, "Diamonds"),
      Card.new(4, "Clubs"),
      Card.new(5, "Hearts"),
      Card.new("Ace", "Clubs"),
    ],
  )
puts hand.evaluate == "Straight"

hand =
  PokerHand.new(
    [
      Card.new("Queen", "Clubs"),
      Card.new("King", "Diamonds"),
      Card.new(10, "Clubs"),
      Card.new("Ace", "Hearts"),
      Card.new("Jack", "Clubs"),
    ],
  )
puts hand.evaluate == "Straight"

hand =
  PokerHand.new(
    [
      Card.new(3, "Hearts"),
      Card.new(3, "Clubs"),
      Card.new(5, "Diamonds"),
      Card.new(3, "Spades"),
      Card.new(6, "Diamonds"),
    ],
  )
puts hand.evaluate == "Three of a kind"

hand =
  PokerHand.new(
    [
      Card.new(9, "Hearts"),
      Card.new(9, "Clubs"),
      Card.new(5, "Diamonds"),
      Card.new(8, "Spades"),
      Card.new(5, "Hearts"),
    ],
  )
puts hand.evaluate == "Two pair"

hand =
  PokerHand.new(
    [
      Card.new(2, "Hearts"),
      Card.new(9, "Clubs"),
      Card.new(5, "Diamonds"),
      Card.new(9, "Spades"),
      Card.new(3, "Diamonds"),
    ],
  )
puts hand.evaluate == "Pair"

hand =
  PokerHand.new(
    [
      Card.new(2, "Hearts"),
      Card.new("King", "Clubs"),
      Card.new(5, "Diamonds"),
      Card.new(9, "Spades"),
      Card.new(3, "Diamonds"),
    ],
  )
puts hand.evaluate == "High card"
