module API

  module Messages

    class SeatAvailabilityRQ < API::Messages::Base

      @response_name = "seat_availability"
      class << self
        attr_reader :response_name
      end

      attr_reader :cabins, :flight_segment_list, :seats, :services

      def initialize(doc)
        super (doc)

        begin
          cabins = []
          seats = []
          services = []

          @doc.xpath('/SeatAvailabilityRQ/DataList/FlightSegmentList/FlightSegment').each do |fs|
            aircraft_code = fs.xpath('./Equipment/AircraftCode').text
            service_class_code = fs.xpath('./ClassOfService/Code').text
            segment_key = fs.attribute("SegmentKey").text

            cabin = Cabin.fetch_cabins(aircraft_code, service_class_code, segment_key)
            cabins.push(cabin)

            seat = Seat.where(cabin_id: cabin.id).first
            seats.push(seat)

            dep = fs.xpath('./Departure/AirportCode').text
            arr = fs.xpath('./Arrival/AirportCode').text
            dep_date = fs.xpath('./Departure/Date').text
            service = Service.fetch_by_od(dep, arr, dep_date, segment_key)
            service.each do |s| 
              services.push(s) 
            end
          end

          @cabins = cabins
          @seats = seats
          @services = services
          @response = build_response
        rescue => error
          @errors << API::Messages::Errors::UnknownNDCProcessingError.new("UnknownNDCProcessingError: #{error}")
        end
      end

    end

  end

end
