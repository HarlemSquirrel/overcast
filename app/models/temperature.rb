# frozen_string_literal: true

##
# Temperature in various units
#
class Temperature
  attr_reader :kelvin

  def initialize(kelvin)
    @kelvin = kelvin
  end

  def celsius
    (kelvin - 273.15).round(1)
  end

  def fahrenheit
    ((celsius * 1.8) + 32).round(1)
  end
end
