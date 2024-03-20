require "test_helper"

class ForecastTest < ActiveSupport::TestCase
  test "#description" do
    forecast = Forecast.new(data_str: { weather: [{ "description": "cloudy" }]}.to_json)
    assert_equal "cloudy", forecast.description
  end

  test "#emoji" do
    forecast = Forecast.new(data_str: { weather: [{ "description": "cloudy" }]}.to_json)
    assert_equal "☁️", forecast.emoji

    forecast = Forecast.new(data_str: { weather: [{ "description": "light rain" }]}.to_json)
    assert_equal "🌧️", forecast.emoji
  end

  test "#stale?" do
    forecast = Forecast.new(updated_at: 31.minutes.ago)
    assert "cloudy", forecast.stale?
  end
end
