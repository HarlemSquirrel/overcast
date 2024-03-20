# frozen_string_literal: true

require 'test_helper'

class OpenWeatherTest < ActiveSupport::TestCase
  test 'can get weather with a geocoded location' do
    VCR.use_cassette('1_times_square_weather') do
      geocoded_location = GeocodedLocation.new('1 times square, new york, ny')
      weather = OpenWeather.new(geocoded_location)
      # assert geocoded_location.found?
      assert weather.weather_data_str
    end
  end
end
