module Sandbox

  module Messages

    class SeatAvailabilityRQ < Sandbox::Messages::Base
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

          # initialize route_x params for loading Services based on Route
          route_dep = ""
          route_dep_date = ""
          route_arr = ""

          # we will use segment_key when loading Service, because Service should associated with FlightSegment through SegmentKey
          segment_key = ""

          # i and total_fs are used for catching first and last FlightSegment by comparing them to each other
          total_fs = @doc.xpath('/SeatAvailabilityRQ/DataList/FlightSegmentList/FlightSegment').count
          i = 1

          @doc.xpath('/SeatAvailabilityRQ/DataList/FlightSegmentList/FlightSegment').each do |fs|
            # assign values
            dep = fs.xpath('./Departure/AirportCode').text
            dep_time = fs.xpath('./Departure/Time').text
            dep_date = fs.xpath('./Departure/Date').text
            arr = fs.xpath('./Arrival/AirportCode').text
            arr_time = fs.xpath('./Arrival/Time').text
            segment_key = fs.attribute("SegmentKey").text

            # assign route_x params catching first and last FlightSegment, this is used for loading Route
            route_arr = arr if i==total_fs
            route_dep = dep if i==1
            route_dep_date = dep_date if i==1

            # load FlightSegment
            flight_segment = FlightSegment.fetch_by_od(dep, dep_time, arr, arr_time, segment_key)

            # load cabins based on current flight_segment
            @cabins = @cabins + Cabin.fetch_by_flight_segment(flight_segment.id, segment_key)

            # load seats based on current flight_segment, because Cabins now are associated with FlightSegment
            # p.s. we are not passing @cabins.id because @cabins variable is an array. Take a look at Seat.fetch_by_flight_segment method
            @seats = @seats + Seat.fetch_by_flight_segment(flight_segment.id)

            # we need array of FlightSegments to render it on SeatAvailability/DataList/FlightSegmentList
            @flight_segment_list.push(flight_segment)

            # old school way of determining current index of loop
            i = i + 1
          end

          # Load services outside of loop based on route_x params they are needed to load Route at first
          @services = @services + Service.fetch_by_od(route_dep, route_arr, route_dep_date, segment_key)
          @response = build_response
        rescue => error
          @errors << Sandbox::Messages::Errors::UnknownNDCProcessingError.new("UnknownNDCProcessingError: #{error}")
        end
      end

    end

  end

end
