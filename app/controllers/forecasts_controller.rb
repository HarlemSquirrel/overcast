# frozen_string_literal: true

##
# Controller for forecasts
#
class ForecastsController < ApplicationController
  def index
    query = params[:q]
    return if query.blank?

    @location = GeocodedLocation.new(params[:q])

    if @location.found?
      postal_code = @location.postal_code

      @forecast = Forecast.find_or_initialize_by(postal_code:)

      @forecast.data_str = OpenWeather.new(@location).weather_data_str if @forecast.stale?

      @errors = @forecast.errors unless @forecast.save
    else
      @errors = [StandardError.new("Could not find a location for #{query}")]
    end
  end
end
