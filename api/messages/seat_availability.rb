module API

  module Messages

    class SeatAvailabilityRQ < API::Messages::Base

      @response_name = "seat_availability"
      class << self
        attr_reader :response_name
      end

      def initialize(doc)
        super (doc)
        @response = build_response
      end

    end

  end

end
