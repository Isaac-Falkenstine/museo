class Curator
  attr_reader :artists,
              :photographs
  def initialize
    @artists = []
    @photographs = []
  end

  def add_photograph(photo)
    @photographs << photo
  end

  def add_artist(artist)
    @artists << artist
  end

  def name

  end

  def find_artist_by_id(artist_id)

  end

  def find_photograph_by_id(photo_id)

  end
end
