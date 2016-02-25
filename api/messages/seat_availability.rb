module API

  module Messages

    class SeatAvailabilityRQ < API::Messages::Base

      @response_name = "seat_availability"
      class << self
        attr_reader :response_name, :cabin, :aircraft
      end

      def initialize(doc)
        super (doc)
        begin
          fsl = @doc.xpath('/SeatAvailabilityRQ/DataList/FlightSegmentList').first
          aircraft_code = fsl.xpath('Equipment/AircraftCode').text
          class_of_service = fsl.('ClassOfService/Code').text
          @aircraft = Aircraft.where(code: aircraft_code)
          @cabin = aircrafts.cabins.where(code: class_of_service)

          @services = routes.services.load
          @response = build_response
        rescue => error
          @errors << API::Messages::Errors::UnknownNDCProcessingError.new("UnknownNDCProcessingError: #{error}")
        end
      end

    end

  end

end
