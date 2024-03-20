class ForecastsController < ApplicationController
  def index
    respond_to do |format|
      format.html do
        q = params[:q]
        if q.present?
          # Geocode
          @location = Geocoder.search(params[:q], limit: 1).first
          postal_code = @location.postal_code

          @forecast = Forecast.find_or_initialize_by(postal_code: postal_code)

          if @forecast.stale?
            @forecast.data_str = OpenWeather.new(@location).weather_data_str
          end

          @forecast.save!
        end
      end
    end
  end
end
