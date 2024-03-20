# frozen_string_literal: true

##
# Cached geolocation data
#
class GeocodedLocation
  CACHE_DURATION = 1.hour

  delegate :city, :country_code, :latitude, :longitude, :postal_code, :place_id, :state, to: :cached_location, allow_nil: true

  def initialize(query)
    @query = query.strip.downcase
  end

  def found?
    cached_location.present?
  end

  private

  attr_reader :query

  def cached_location
    @cached_location ||= Rails.cache.fetch("cached_location/#{query}", expires_in: CACHE_DURATION) do
      Rails.logger.debug { "Refreshing cache for cached_location/#{query}" }
      Geocoder.search(query, limit: 1).first
    end
  end
end
