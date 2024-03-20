##
# Retrieve weather data from OpenWeather API
#
class OpenWeather
  HEADERS = {'Content-type' => 'application/json; charset=UTF-8' }
  URI = URI('https://api.openweathermap.org').freeze

  class Error < StandardError; end

  attr_reader :location

  def initialize(location)
    @location = location
  end

  def weather_data_str
    case response
    when Net::HTTPSuccess then
      response.body
    else
      raise Error, response
    end
  end

  private

  def api_key
    Rails.application.credentials.open_weather_api_key
  end

  def response
    @response ||= Net::HTTP.start(URI.host, use_ssl: true) do |http|
      # https://api.openweathermap.org/data/3.0/onecall?lat={lat}&lon={lon}&exclude={part}&appid={API key}
      path = "/data/2.5/weather?lat=#{@location.latitude}&lon=#{@location.longitude}&appid=#{api_key}"
      http.get(path, HEADERS)
    end
  end
end
