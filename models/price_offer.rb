require_relative 'base_offer'

class PriceOffer < BaseOffer

  attr_accessor :fare, :flight_segments, :passengers_keys, :base_price_with_taxes

  before_create :set_calculated_price

  def self.fetch_by_flights(flights = [], num_travelers = 1)
    offers = []

    orig = flights.first['Departure']['AirportCode']
    dest = flights.last['Arrival']['AirportCode']
    route = Route.joins(:airline, :fares).where(origin: orig, destination: dest, departure_time: flights.first['Departure']['Time']).limit(1)
    flights.each do |flight|
      query = FlightSegment.joins(:route)
                  .where(
                      departure_airport_code: flight['Departure']['AirportCode'],
                      arrival_airport_code: flight['Arrival']['AirportCode'],
                      departure_time: flight['Departure']['Time'],
                      arrival_time: flight['Arrival']['Time'],
                      route: {
                          origin: orig,
                          destination: dest,
                      }
                  )
                  .where('flight_segments.departure_mask & ? > 0', FlightSegment.available_mask([flight['Departure']['Date']]))
                  .where('flight_segments.arrival_mask & ? > 0', FlightSegment.available_mask([flight['Arrival']['Date']]))
      puts query.to_sql
    end

    route.first.fares.each do |fare|
      offers << PriceOffer.new(
          fare: fare,
          flight_segments: [],
          passengers_keys: [],
      )
    end
    {offers: offers}
  end

  private

  def set_calculated_price
   fare.base_price  = 1.5 * fare.base_price
  end
end