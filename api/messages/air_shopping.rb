module API

  module Messages

    class AirShoppingRQ < API::Messages::Base

      @response_name = "air_shopping"
      class << self
        attr_reader :response_name
      end

      attr_reader :offers, :offers_count, :services, :bundles, :num_travelers

      def initialize(doc)
        super (doc)
        begin
          ond = @doc.xpath('/AirShoppingRQ/CoreQuery/OriginDestinations/OriginDestination').first
          dep = ond.xpath('Departure/AirportCode').text
          arr = ond.xpath('Arrival/AirportCode').text
          date_dep = DateTime.parse(ond.xpath('Departure/Date').text) if ond.xpath('Departure/Date')
          date_arr = DateTime.parse(ond.xpath('Arrival/Date').text) if ond.xpath('Arrival/Date').present?
          @num_travelers = @doc.xpath('/AirShoppingRQ/Travelers/Traveler/AnonymousTraveler/PTC').first.attributes["Quantity"].value ? doc.xpath('/AirShoppingRQ/Travelers/Traveler/AnonymousTraveler/PTC').first.attributes["Quantity"].value.to_i : nil
          ShoppingStore.save_request(dep, arr, ond.xpath('Departure/Date').text, @token, num_travelers)
          results = Offer.fetch_by_ond_and_dates(dep, arr, date_dep, date_arr, num_travelers)
          @offers = results[:offers]
          @services = Service.fetch_by_od(dep, arr, ond.xpath('Departure/Date').text, "")
          @bundles = Bundle.fetch_by_od(dep, arr, ond.xpath('Departure/Date').text)
          @datalist_flight_segments = results[:datalists][:flight_segments]
          @datalist_passengers = results[:datalists][:passengers]
          @offers_count = @offers.size
          @response = build_response
        rescue => error
          @errors << API::Messages::Errors::UnknownNDCProcessingError.new("UnknownNDCProcessingError: #{error}")
        end
      end

    end
  end

end
