require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer'
require './lib/dog'
require './lib/day_care'
require 'pry'

class DayCareTest < MiniTest::Test
  def test_it_exists
    day_care = DayCare.new("The Dog Spot")
    assert_instance_of DayCare, day_care
  end
