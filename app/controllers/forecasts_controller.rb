class ForecastsController < ApplicationController
  def index
    respond_to do |format|
      format.html do
        query = params[:q]
        if query.present?
          # Geocode
          # @location = Geocoder.search(params[:q], limit: 1).first
          @location = GeocodedLocation.new(params[:q])

          if @location.found?
            postal_code = @location.postal_code

            @forecast = Forecast.find_or_initialize_by(postal_code: postal_code)

            if @forecast.stale?
              @forecast.data_str = OpenWeather.new(@location).weather_data_str
            end

            @forecast.save!
            # binding.break
          else
            @errors = [StandardError.new("Could not find a location for #{query}")]
          end
        end
      end
    end
  end
end
