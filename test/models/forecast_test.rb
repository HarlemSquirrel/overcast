# frozen_string_literal: true

require 'test_helper'

class ForecastTest < ActiveSupport::TestCase
  test '#description' do
    forecast = forecasts(:nyc)
    assert_equal 'broken clouds', forecast.description
  end

  test '#humidity' do
    forecast = forecasts(:nyc)
    assert_equal 54, forecast.humidity
  end

  test '#pressure' do
    forecast = forecasts(:nyc)
    assert_equal 1006, forecast.pressure
  end

  test '#temperature' do
    forecast = forecasts(:nyc)
    assert_equal Temperature.new(280.39), forecast.temperature
  end

  test '#stale?' do
    forecast = Forecast.new(updated_at: 31.minutes.ago)
    assert forecast.stale?
  end
end
