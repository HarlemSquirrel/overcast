# frozen_string_literal: true

require 'test_helper'

class GeocodedLocationTest < ActiveSupport::TestCase
  test 'find by address' do
    VCR.use_cassette('1_times_square_location') do
      geocoded_location = GeocodedLocation.new('1 times square, new york, ny')
      assert geocoded_location.found?
      assert_equal '10036', geocoded_location.postal_code
      assert_equal 'us', geocoded_location.country_code
    end
  end
end
