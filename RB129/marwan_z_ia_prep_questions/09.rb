class Song
  attr_reader :title, :artist

  def initialize(title)
    @title = title
    @artist
  end

  def artist=(name)
    @artist = name.upcase
  end
end

p song = Song.new("Superstition")
p song.artist = "Stevie Wonder"
p song.artist