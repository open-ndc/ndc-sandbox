
require_relative 'base_offer'

class Offer < BaseOffer

  attr_accessor :airline_code, :route_origin, :route_destination, :date_departure, :date_return, :base_price, :fare_currency, :datetime_expiration, :taxes_applicable,
                :flight_segments, :offer_flight_segments, :passengers_list, :passengers_keys

  validates_presence_of :airline_code, :route_origin, :route_destination

  before_create :set_expiration, :set_calculated_price

  def initialize(hash)
    super(hash)
  end

  # Class methods

  def self.fetch_by_ond_and_dates(origin, destination, date_departure, date_return = nil, num_travelers = 1)
    #TODO Implement dates and availability
    offers_query = Route.joins(:fares, :airline).select("routes.*, #{Fare::JOIN_COLUMNS.collect{|col| "fares.#{col} as #{col}" }.join(', ') }, airlines.code as airline_code").where(origin: origin, destination: destination)

    passengers_list = [{key: 'SH1', quantity: num_travelers}]
    passengers_keys = passengers_list.collect{|pas| pas[:key]}

    full_flight_segments_list = DataList.new

    offers_results = []
    offers_query.each{|offer|
      offer_flight_segments = []
      offer_flight_segments_keys = []
      offer.flight_segments.each{|fs|
        new_segment = DataList::ListItem.new(fs.id, (fs.attributes.merge(COS: offer.service_class)))
        offer_flight_segments << new_segment
        new_key = full_flight_segments_list << new_segment
        offer_flight_segments_keys << new_key
      }
      offers_results << Offer.new(
                                  airline_code: offer.airline_code,
                                  route_origin: offer.origin,
                                  route_destination: offer.destination,
                                  date_departure: date_departure, # Offer dates are now fake
                                  date_return: date_return, #Offer dates are now fake
                                  base_price: offer.base_price,
                                  fare_currency: offer.currency,
                                  taxes_applicable: offer.taxes_applicable,
                                  offer_flight_segments: offer_flight_segments,
                                  flight_segments: offer_flight_segments,
                                  passengers_keys: passengers_keys
                                )
    }
    return {offers: offers_results, datalists: {flight_segments: full_flight_segments_list, passengers: passengers_list}}
  end

  def taxes_price
    base_price * taxes_applicable
  end

  def base_price_with_taxes
    base_price + taxes_price
  end

  private

  def set_calculated_price
    self.base_price = base_price * 1.5
  end

end
