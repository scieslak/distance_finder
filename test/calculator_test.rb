require 'test_helper'

class DistanceFinderTest < Minitest::Test

  @@origin = "Slough"
  @@destination = "Basingstoke"
  @@route = DistanceFinder::Calculator.new(@@origin, @@destination)


  def test_can_output_distance
    assert @@route.distance
  end

  def test_can_output_duration
    assert @@route.duration
  end

  def test_can_output_end_address
    assert @@route.end_address.downcase.include?(@@destination.downcase)
  end

  def test_can_output_start_address
    assert @@route.start_address.downcase.include?(@@origin.downcase)
  end


  def test_can_build_url
    url = "https://maps.googleapis.com/maps/api/directions/json?origin=#{@@origin}&destination=#{@@destination}"
    assert_equal @@route.build_url, url
  end

  def test_can_parse_response
    refute @@route.parse_response["status"].nil?
  end

  def test_can_get_response
    assert @@route.get_response
  end

end
