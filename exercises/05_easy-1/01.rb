class Banner
  def initialize(message, width = 0)
    @message = message
    @width = [width, message.size].max
  end

  def to_s
    [
      horizontal_rule,
      empty_line,
      message_line,
      empty_line,
      horizontal_rule,
    ].join("\n")
  end

  private

  def horizontal_rule
    "+-" + "-" * (@width) + "-+"
  end

  def empty_line
    "| " + " " * (@width) + " |"
  end

  def message_line
    "| #{@message.center(@width)} |"
  end
end

banner = Banner.new("To boldly go where no one has gone before.")
puts banner

banner = Banner.new("")
puts banner

banner = Banner.new("Test", 18)
puts banner

banner = Banner.new("Width input is less than length of message", 8)
puts banner
