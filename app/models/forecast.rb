class Forecast < ApplicationRecord
  def data
    @data ||= JSON.parse(data_str)
  end

  def description
    data.dig("weather", 0, "description")
  end

  def humidity
    data.dig("main", "humidity")
  end

  def icon_code
    weather.dig(0, "icon")
  end

  def latitude
    data.dig("coord", "lat")
  end

  def longitude
    data.dig("coord", "lon")
  end

  def pressure
    data.dig("main", "pressure")
  end

  def stale?
    updated_at.blank? || updated_at < 30.minutes.ago
  end

  def temperature
    @temperature ||= Temperature.new data.dig("main", "temp")
  end

  def temperature_max
    @temperature_max ||= Temperature.new data.dig("main", "temp_max")
  end

  def temperature_min
    @temperature_min ||= Temperature.new data.dig("main", "temp_min")
  end

  def weather
    data["weather"]
  end
end
