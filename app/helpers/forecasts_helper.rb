# frozen_string_literal: true

##
# Forecast helpers
#
module ForecastsHelper
  def icon_url(forecast)
    "https://openweathermap.org/img/wn/#{forecast.icon_code}@2x.png"
  end
end
