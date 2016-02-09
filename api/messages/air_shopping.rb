module API

  module Messages

    class AirShoppingRQ < API::Messages::Base
      require "redis"
      require "byebug"

      @response_name = "air_shopping"
      class << self
        attr_reader :response_name
      end

      attr_reader :offers, :offers_count

      def initialize(doc)
        super (doc)
        ond = @doc.xpath('/AirShoppingRQ/CoreQuery/OriginDestinations/OriginDestination').first
        dep = ond.xpath('Departure/AirportCode').text
        arr = ond.xpath('Arrival/AirportCode').text
        date_dep = DateTime.parse(ond.xpath('Departure/Date').text) if ond.xpath('Departure/Date')
        date_arr = DateTime.parse(ond.xpath('Arrival/Date').text) if ond.xpath('Arrival/Date').present?
        num_travelers = @doc.xpath('/AirShoppingRQ/Travelers/Traveler/AnonymousTraveler/PTC').first.attributes["Quantity"].value ? doc.xpath('/AirShoppingRQ/Travelers/Traveler/AnonymousTraveler/PTC').first.attributes["Quantity"].value.to_i : nil
        save_request(dep, arr, date_dep)
        results = Offer.fetch_by_ond_and_dates(dep, arr, date_dep, date_arr, num_travelers)
        @offers = results[:offers]
        @datalist_flight_segments = results[:datalists][:flight_segments]
        @datalist_passengers = results[:datalists][:passengers]
        @offers_count = @offers.size
        @response = build_response
      end

      def save_request(dep, arr, date_dep)
        redis = Redis.new
        hash = {"dep" => dep, "arr" => arr, "date_dep" => date_dep}
        redis.set(@token, hash.to_json)
      end

    end

  end

end
