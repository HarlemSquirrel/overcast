# frozen_string_literal: true

require 'test_helper'

class ForecastTest < ActiveSupport::TestCase
  test "#celsius" do
    temperature = Temperature.new(280.39)
    assert_equal 7.2, temperature.celsius
  end

  test "#fahrenheit" do
    temperature = Temperature.new(280.39)
    assert_equal 45.0, temperature.fahrenheit
  end
end
