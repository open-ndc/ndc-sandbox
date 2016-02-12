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
<<<<<<< HEAD
        @offers = PriceOffer.fetch_by_flights(flights)
        @datalist_flight_segments = []
=======
        results = PriceOffer.fetch_by_flights(flights)
        @offers = results[:offers]
        @datalist_flight_segments = results[:full_flight_segments_list]
>>>>>>> 3dd0e1ea9663b056fb5ae40158f18cf99a24cdab
        @datalist_passengers = []
        @response = build_response
      end

      def parse_xml(doc)
        flight_stack = []
<<<<<<< HEAD
        originDestinations = doc.xpath("#{self.name}/Query").css('OriginDestination')
        originDestinations.each do |originDestination|
          way = []
          originDestination.css('Flight').each do |flight|
            way << Hash.from_xml(flight.children.to_s)
          end
          flight_stack << way
        end
=======
        originDestinations = doc.xpath("#{@method}/Query").css('OriginDestination')
        originDestinations.each do |originDestination|
          trip = []
          originDestination.css('Flight').each do |flight|
            trip << Hash.from_xml(flight.to_s)['Flight']
          end
          flight_stack << trip
        end
        flight_stack
>>>>>>> 3dd0e1ea9663b056fb5ae40158f18cf99a24cdab
      end

    end

  end

end
