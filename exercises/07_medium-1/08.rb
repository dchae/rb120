# class Card
#   include Comparable
#   attr_reader :rank, :suit

#   def initialize(rank, suit)
#     @rank = rank
#     @suit = suit
#     @value = card_value(rank)
#   end

#   def <=>(other)
#     value <=> other.value
#   end

#   def to_s
#     "#{rank} of #{suit}"
#   end

#   protected

#   attr_reader :value

#   private

#   def card_value(rank)
#     if rank.is_a? Integer
#       rank - 1
#     else
#       "JQKA".index(rank[0]) + 10
#     end
#   end
# end

# FE
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

cards = [
  Card.new(2, "Hearts"),
  Card.new(10, "Diamonds"),
  Card.new("Ace", "Clubs"),
]
puts cards
puts cards.min == Card.new(2, "Hearts")
puts cards.max == Card.new("Ace", "Clubs")

cards = [Card.new(5, "Hearts")]
puts cards.min == Card.new(5, "Hearts")
puts cards.max == Card.new(5, "Hearts")

cards = [Card.new(4, "Hearts"), Card.new(4, "Diamonds"), Card.new(10, "Clubs")]
puts cards.min.rank == 4
puts cards.max == Card.new(10, "Clubs")

cards = [
  Card.new(7, "Diamonds"),
  Card.new("Jack", "Diamonds"),
  Card.new("Jack", "Spades"),
]
puts cards.min == Card.new(7, "Diamonds")
puts cards.max.rank == "Jack"

cards = [Card.new(8, "Clubs"), Card.new(8, "Diamonds"), Card.new(8, "Spades")]
puts cards.min.rank == 8
puts cards.max.rank == 8
puts cards.sort.map(&:suit)
