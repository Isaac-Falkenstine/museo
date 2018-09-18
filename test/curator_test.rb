require 'minitest/autorun'
require 'minitest/pride'
require './lib/curator'
require './lib/photograph'
require './lib/artist'
require 'pry'
require "csv"

class CuratorTest < MiniTest::Test
  def test_it_exists
    curator = Curator.new
    assert_instance_of Curator, curator
  end

  def test_it_starts_with_no_photographs_and_no_artist
    curator = Curator.new
    assert_equal [], curator.artists
    assert_equal [], curator.photographs
  end

  def setup
    @curator = Curator.new
    @photo_1 = Photograph.new({
          id: "1",
          name: "Rue Mouffetard, Paris (Boy with Bottles)",
          artist_id: "1",
          year: "1954"
        })

    @photo_2 = Photograph.new({
          id: "2",
          name: "Moonrise, Hernandez",
          artist_id: "2",
          year: "1941"
        })

    @photo_3 = Photograph.new({
          id: "3",
          name: "Identical Twins, Roselle, New Jersey",
          artist_id: "3",
          year: "1967"
        })

    @photo_4 = Photograph.new({
          id: "4",
          name: "Child with Toy Hand Grenade in Central Park",
          artist_id: "3",
          year: "1962"
        })
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @artist_1 = Artist.new({
          id: "1",
          name: "Henri Cartier-Bresson",
          born: "1908",
          died: "2004",
          country: "France"
        })

    @artist_2 = Artist.new({
          id: "2",
          name: "Ansel Adams",
          born: "1902",
          died: "1984",
          country: "United States"
        })
    @artist_3 = Artist.new({
          id: "3",
          name: "Diane Arbus",
          born: "1923",
          died: "1971",
          country: "United States"
        })
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
  end

  def test_it_can_add_photogrpahs
    assert_equal [@photo_1, @photo_2], @curator.photographs
    assert_equal @photo_1, @curator.photographs.first
    expected = "Rue Mouffetard, Paris (Boy with Bottles)"
    assert_equal expected, @curator.photographs.first.name
  end

  def test_it_can_add_artist
    assert_equal [@artist_1, @artist_2], @curator.artists
    assert_equal @artist_1,  @curator.artists.first
    assert_equal "Henri Cartier-Bresson", @curator.artists.first.name
  end

  def test_it_can_find_artist_by_id
    assert_equal @artist_1, @curator.find_artist_by_id("1")
    assert_equal @photo_2, @curator.find_photograph_by_id("2")
  end

  def test_can_find_photo_by_artist_id
    @curator.add_artist(@artist_3)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    diane_arbus = @curator.find_artist_by_id("3")
    assert_equal @artist_3, diane_arbus
    actual = @curator.find_photographs_by_artist(diane_arbus)
    assert_equal [@photo_3,@photo_4], actual
  end

  def test_can_find_all_artist_with_multiple_photos
    @curator.add_artist(@artist_3)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    diane_arbus = @curator.find_artist_by_id("3")
    assert_equal [@artist_3], @curator.artists_with_multiple_photographs
    assert_equal 1, @curator.artists_with_multiple_photographs.length
    assert diane_arbus == @curator.artists_with_multiple_photographs.first
  end

  def test_it_can_return_photos_taken_by_artist_from_a_given_country
    @curator.add_artist(@artist_3)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    actual = @curator.photographs_taken_by_artists_from("United States")
    assert_equal [@photo_2, @photo_3, @photo_4], actual
    assert_equal [], @curator.photographs_taken_by_artists_from("Argentina")
  end

  def test_it_can_read_from_a_csv_file
    curator_1 = Curator.new #I do this to seperate the csv curator from the one
    curator_1.load_photographs('./data/photographs.csv') #I define in my setup
    curator_1.load_artists('./data/artists.csv')
  end

  def test_it_can_find_photos_in_a_year_range
    curator_1 = Curator.new
    photographs = curator_1.load_photographs('./data/photographs.csv')
    artists = curator_1.load_artists('./data/artists.csv')
    expected = [curator_1.find_photograph_by_id("1"),
                curator_1.find_photograph_by_id("4")]
    assert_equal expected, curator_1.photographs_taken_between(1950..1965)
  end

  def test_it_can_return_a_hash_with_age_photo_pairs
    curator_1 = Curator.new
    photographs = curator_1.load_photographs('./data/photographs.csv')
    artists = curator_1.load_artists('./data/artists.csv')
    diane_arbus = curator_1.find_artist_by_id("3")
    expected = {44=>"Identical Twins, Roselle, New Jersey",
                39=>"Child with Toy Hand Grenade in Central Park"}
    assert_equal expected, curator_1.artists_photographs_by_age(diane_arbus)
  end
end
