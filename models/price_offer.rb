require_relative 'base_offer'

class PriceOffer < BaseOffer

  attr_accessor :base_price, :fare_currency, :datetime_expiration, :taxes_applicable,
                :flight_segments, :offer_flight_segments, :passengers_list, :passengers_keys
  def self.fetch_by_flights(flights = [], num_travelers = 1)
    flights.each do |flight|

    end
  end


end