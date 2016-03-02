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
          cabins = []
          seats = []
          services = []

          @doc.xpath('/SeatAvailabilityRQ/DataList/FlightSegmentList/FlightSegment').each do |fs|
            dep = fs.xpath('./Departure/AirportCode').text
            dep_time = fs.xpath('./Departure/Time').text
            dep_date = fs.xpath('./Departure/Date').text
            arr = fs.xpath('./Arrival/AirportCode').text
            arr_time = fs.xpath('./Arrival/Time').text
            segment_key = fs.attribute("SegmentKey").text

            flight_segment = FlightSegment.where(departure_airport_code: dep, departure_time: dep_time, arrival_airport_code: arr, arrival_time: arr_time).first
            cabins = cabins + Cabin.fetch_by_flight_segment(flight_segment.id, segment_key)
            seats = seats + Seat.fetch_by_flight_segment(flight_segment.id)
            services = services + Service.fetch_by_od(dep, arr, dep_date, segment_key)
          end

          @flight_segment_list = HTMLEntities.new.decode(@doc.xpath('/SeatAvailabilityRQ/DataList/FlightSegmentList'))
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
