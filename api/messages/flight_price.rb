module Sandbox

  module Messages

    class FlightPriceRQ < Sandbox::Messages::Base

      @response_name = 'flight_price'
      class << self
        attr_reader :response_name
      end

      attr_reader :offers

      def initialize(doc)
        super (doc)
        flights = parse_xml(@doc)

        results = PriceOffer.fetch_by_flights(flights)
        @offers = results[:offers]
        @datalist_flight_segments = results[:full_flight_segments_list]

        @datalist_passengers = []
        @response = build_response
      end

      def parse_xml(doc)
        flight_stack = []
        originDestinations = doc.xpath("#{@method}/Query").css('OriginDestination')
        originDestinations.each do |originDestination|
          trip = []
          originDestination.css('Flight').each do |flight|
            trip << Hash.from_xml(flight.to_s)['Flight']
          end
          flight_stack << trip
        end
        flight_stack
      end

    end

  end

end
