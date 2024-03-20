# frozen_string_literal: true

##
# Controller for forecasts
#
class ForecastsController < ApplicationController
  def index
    query = params[:q]
    return if query.blank?

    @location = GeocodedLocation.new(params[:q])

    if !@location.found?
      @errors = ["Could not find a location for #{query}"]
      return
    end

    # Try to cache by postal code but fall back to place ID for more general locations like a big city.
    if @location.postal_code
      @forecast = Forecast.find_or_initialize_by(postal_code: @location.postal_code)
      @forecast.place_id ||= @location.place_id
    else
      @forecast = Forecast.find_or_initialize_by(place_id: @location.place_id)
    end

    @forecast.data_str = OpenWeather.new(@location).weather_data_str if @forecast.stale?

    unless @forecast.save
      Rails.logger.warn("Failed to save forecast. #{@forecast.errors.full_messages.join('. ')}.")
    end
  end
end
