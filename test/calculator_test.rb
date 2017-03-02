require 'test_helper'

class DistanceFinderTest < Minitest::Test

  @@origin = "Slough"
  @@destination = "Basingstoke"
  @@route = DistanceFinder::Calculator.new(@@origin, @@destination)


  def test_can_output_distance
    refute @@route.distance.nil?
  end

  def test_can_output_duration
    refute @@route.duration.nil?
  end

  def test_can_output_end_address
    refute @@route.end_address.nil?
  end

  def test_can_output_start_address
    refute @@route.start_address.nil?
  end


  def test_can_build_url
    url = "https://maps.googleapis.com/maps/api/directions/json?origin=#{@@route.convert_input(@@origin)}&destination=#{@@route.convert_input(@@destination)}&units=imperial&mode=driving"
    assert_equal @@route.build_url, url
  end

  def test_can_parse_response
    refute @@route.parse_response["status"].nil?
  end

  def test_can_get_response
    assert @@route.get_response
  end

  def test_convert_input
    assert_equal @@route.convert_input("ĀāĂăĄąĆćĈĉĊċČčĎďĐđĒēĔĕĖėĘęĚěĜĝĞğĠġĢģĤĥĦħĨĩĪīĬĭĮįİıĲĳĴĵĶķĸĹĺĻļĽľĿŀŁłŃńŅņŇň"),
    "AaAaAaCcCcCcCcDdDdEeEeEeEeEeGgGgGgGgHhHhIiIiIiIiIiIJijJjKkkLlLlLlLlLlNnNnNn"
  end

end
