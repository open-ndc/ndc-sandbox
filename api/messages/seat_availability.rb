module API

  module Messages

    class SeatAvailabilityRQ < API::Messages::Base

      @response_name = "seat_availability"
      class << self
        attr_reader :response_name
      end

      attr_reader :cabins, :flight_segment_list, :seats

      def initialize(doc)
        super (doc)

        begin
          cabins = []
          seats = []
          @doc.xpath('/SeatAvailabilityRQ/DataList/FlightSegmentList/FlightSegment').each do |fs|
            aircraft_code = fs.xpath('./Equipment/AircraftCode').text
            service_class_code = fs.xpath('./ClassOfService/Code').text
            segment_key = fs.attribute("SegmentKey").text
            cabin = Cabin.fetch_cabins(aircraft_code, service_class_code, segment_key)
            seat = Seat.where(cabin_id: cabin.id).first
            seats.push(seat)
            cabins.push(cabin)
          end

          @cabins = cabins
          @seats = seats
          @response = build_response
        rescue => error
          @errors << API::Messages::Errors::UnknownNDCProcessingError.new("UnknownNDCProcessingError: #{error}")
        end
      end

    end

  end

end
