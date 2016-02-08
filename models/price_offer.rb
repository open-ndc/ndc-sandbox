require_relative 'base_offer'

class PriceOffer < BaseOffer

  OD_KEY = 'OD'

  attr_accessor :fare, :flight_segments, :passengers_keys, :base_price_with_taxes, :dest_key

  before_create :set_calculated_price

  def self.fetch_by_flights(originDestinations = [], num_travelers = 1)
    offers = []
    full_flight_segments_list = DataList.new
    originDestinations.each_with_index do |flights, index|
      orig = flights.first['Departure']['AirportCode']
      dest = flights.last['Arrival']['AirportCode']
      break unless (route = Route.joins(:airline, :fares).where(origin: orig, destination: dest, departure_time: flights.first['Departure']['Time']).first)
      offer_flight_segments = []
      flights.each do |flight|
        result = FlightSegment.joins(:route)
                    .where(
                        departure_airport_code: flight['Departure']['AirportCode'],
                        arrival_airport_code: flight['Arrival']['AirportCode'],
                        departure_time: flight['Departure']['Time'],
                        arrival_time: flight['Arrival']['Time'],
                        routes: {
                            origin: orig,
                            destination: dest,
                        }
                    )
                    .where('flight_segments.departure_mask & ? > 0', FlightSegment.available_mask([flight['Departure']['Date']]))
                    .where('flight_segments.arrival_mask & ? > 0', FlightSegment.available_mask([flight['Arrival']['Date']]))
        break unless (fs = result.first)
        new_segment = DataList::ListItem.new(fs.id, {ref_key: 'SEG', data: fs})
        offer_flight_segments << new_segment
        _new_key = full_flight_segments_list << new_segment
      end
      route.fares.each do |fare|
        offers << PriceOffer.new(
            dest_key: OD_KEY + (index + 1).to_s,
            fare: fare,
            flight_segments: offer_flight_segments,
            passengers_keys: [],
        )
      end
    end
    {offers: offers, full_flight_segments_list: full_flight_segments_list}
  end

  private

  def set_calculated_price
   fare.base_price  = 1.5 * fare.base_price
  end
end