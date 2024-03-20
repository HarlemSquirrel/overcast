class Forecast < ApplicationRecord
  def data
    @data ||= JSON.parse(data_str)
  end

  def emoji
    case description
    in /cloud/
      "☁️"
    in /fog/
      "🌫️"
    in /(rain|sleet)/
      "🌧️"
    in /snow/
      "🌨️"
    in /(sun|clear)/
      "☀️"
    else
      "🌤"
    end
  end

  def latitude
    data.dig("coord", "lat")
  end

  def longitude
    data.dig("coord", "lon")
  end

  def description
    data.dig("weather", 0, "description")
  end

  def stale?
    updated_at.blank? || updated_at < 30.minutes.ago
  end

  def temperature
    @temperature ||= Temperature.new data.dig("main", "temp")
  end

  def weather
    data["weather"]
  end
end
