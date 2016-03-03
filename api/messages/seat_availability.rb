module API

  module Messages

    class SeatAvailabilityRQ < API::Messages::Base
      require 'htmlentities'

      @response_name = "seat_availability"
      class << self
        attr_reader :response_name
      end

      attr_reader :cabins, :flight_segment_list, :seats, :services

      def initialize(doc)
        super (doc)

        begin
          @cabins = []
          @seats = []
          @services = []
          @flight_segment_list = []

          @doc.xpath('/SeatAvailabilityRQ/DataList/FlightSegmentList/FlightSegment').each do |fs|
            dep = fs.xpath('./Departure/AirportCode').text
            dep_time = fs.xpath('./Departure/Time').text
            dep_date = fs.xpath('./Departure/Date').text
            arr = fs.xpath('./Arrival/AirportCode').text
            arr_time = fs.xpath('./Arrival/Time').text
            segment_key = fs.attribute("SegmentKey").text

            flight_segment = FlightSegment.fetch_by_od(dep, dep_time, arr, arr_time, segment_key)
            @cabins = @cabins + Cabin.fetch_by_flight_segment(flight_segment.id, segment_key)
            @seats = @seats + Seat.fetch_by_flight_segment(flight_segment.id)
            @services = @services + Service.fetch_by_od(dep, arr, dep_date, segment_key)
            @flight_segment_list.push(flight_segment)
          end

          @response = build_response
        rescue => error
          @errors << API::Messages::Errors::UnknownNDCProcessingError.new("UnknownNDCProcessingError: #{error}")
        end
      end

    end

  end

end
