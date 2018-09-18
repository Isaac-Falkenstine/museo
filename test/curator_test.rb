require 'minitest/autorun'
require 'minitest/pride'
require './lib/curator'
require './lib/photograph'
require './lib/artist'
require 'pry'

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

  def test_it_can_add_photogrpahs
    curator = Curator.new
    photo_1 = Photograph.new({
          id: "1",
          name: "Rue Mouffetard, Paris (Boy with Bottles)",
          artist_id: "1",
          year: "1954"
        })

    photo_2 = Photograph.new({
          id: "2",
          name: "Moonrise, Hernandez",
          artist_id: "2",
          year: "1941"
        })
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    assert_equal [photo_1, photo_2], curator.photographs
    assert_equal photo_1, curator.photographs.first
    expected = "Rue Mouffetard, Paris (Boy with Bottles)"
    assert_equal expected, curator.photographs.first.name
  end

  def test_it_can_add_artist
    curator = Curator.new
    artist_1 = Artist.new({
          id: "1",
          name: "Henri Cartier-Bresson",
          born: "1908",
          died: "2004",
          country: "France"
        })

    artist_2 = Artist.new({
          id: "2",
          name: "Ansel Adams",
          born: "1902",
          died: "1984",
          country: "United States"
        })
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)

    assert_equal [artist_1, artist_2], curator.artists
    assert_equal artist_1,  curator.artists.first
    assert_equal "Henri Cartier-Bresson", curator.artists.first.name
  end

  def test_it_can_find_artist_by_id
    curator = Curator.new
    photo_1 = Photograph.new({
          id: "1",
          name: "Rue Mouffetard, Paris (Boy with Bottles)",
          artist_id: "1",
          year: "1954"
        })

    photo_2 = Photograph.new({
          id: "2",
          name: "Moonrise, Hernandez",
          artist_id: "2",
          year: "1941"
        })
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    artist_1 = Artist.new({
          id: "1",
          name: "Henri Cartier-Bresson",
          born: "1908",
          died: "2004",
          country: "France"
        })

    artist_2 = Artist.new({
          id: "2",
          name: "Ansel Adams",
          born: "1902",
          died: "1984",
          country: "United States"
        })
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)


    assert_equal artist_1, curator.find_artist_by_id("1")
    assert_equal photo_2, curator.find_photograph_by_id("2")
  end
end