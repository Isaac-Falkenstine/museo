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

  def photographs_taken_by_artists_from(country)
    photos_from_artist_from_country = []
    @artists.each do |artist|
      if artist.country == country
        photos_from_artist_from_country << find_photographs_by_artist(artist)
      end
    end
    photos_from_artist_from_country.flatten
  end

  def load_photographs(file)
    contents = CSV.open file, headers: true, header_converters: :symbol
    contents.each do |row|
      photograph_hash = {
        id: row[:id],
        name: row[:name],
        artist_id: row[:artist_id],
        year: row[:year],
      }
      @photographs << photo = Photograph.new(photograph_hash)
    end
    return @photographs
  end

  def load_artists(file)
    contents = CSV.open file, headers: true, header_converters: :symbol
    contents.each do |row|
      artist_hash = {
        id: row[:id],
        name: row[:name],
        born: row[:born],
        died: row[:died],
        country: row[:country]
      }
      @artists << artist = Artist.new(artist_hash)
    end
    return @artists
  end

  def photographs_taken_between(range)
    @photographs.find_all do |photo|
      range === photo.year.to_i
    end
  end
end
