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

  def find_artist_by_id(artist_id)
    @artists.find{|artist|artist.id == artist_id}
  end

  def find_photograph_by_id(photo_id)
    @photographs.find{|photograph|photograph.id == photo_id}
  end

  def find_photographs_by_artist(artist)
    @photographs.find_all do |photograph|
      photograph.artist_id == artist.id
    end
  end

  def artists_with_multiple_photographs
    artists_with_multiple_photos = []
    @artists.each do |artist|
      artist_photos = find_photographs_by_artist(artist)
      if artist_photos.length >= 2
        artists_with_multiple_photos << artist
      end
    end
    artists_with_multiple_photos
  end
end
