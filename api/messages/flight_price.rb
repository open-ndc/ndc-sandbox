module API

  module Messages

    class FlightPriceRQ < API::Messages::Base

      @response_name = 'flight_price'
      class << self
        attr_reader :response_name
      end

      attr_reader :offers

      def initialize(doc)
        super (doc)
        flights = parse_xml(@doc)
        @offers = PriceOffer.fetch_by_flights(flights)
        @datalist_flight_segments = []
        @datalist_passengers = []
        @response = build_response
      end

      def parse_xml(doc)
        flight_stack = []
        originDestinations = doc.xpath("#{self.name}/Query").css('OriginDestination')
        originDestinations.each do |originDestination|
          way = []
          originDestination.css('Flight').each do |flight|
            way << Hash.from_xml(flight.children.to_s)
          end
          flight_stack << way
        end
      end

    end

  end

end
