module API

  module Messages

    class AirShoppingRQ < API::Messages::Base

      attr_reader :offers, :offers_count

      TEMPLATE_PATH = "#{File.dirname(__FILE__)}/templates/air_shopping.xml.rb"

      def initialize(doc)
        super (doc)
        ond = @doc.xpath('/AirShoppingRQ/CoreQuery/OriginDestinations/OriginDestination').first
        dep = ond.xpath('Departure/AirportCode').text
        arr = ond.xpath('Arrival/AirportCode').text
        date_dep = DateTime.parse(ond.xpath('Departure/Date').text) if ond.xpath('Departure/Date')
        date_arr = DateTime.parse(ond.xpath('Arrival/Date').text) if ond.xpath('Arrival/Date').present?
        num_travelers = @doc.xpath('/AirShoppingRQ/Travelers/Traveler/AnonymousTraveler/PTC').first.attributes["Quantity"].value ? doc.xpath('/AirShoppingRQ/Travelers/Traveler/AnonymousTraveler/PTC').first.attributes["Quantity"].value.to_i : nil
        results = Offer.fetch_by_ond_and_dates(dep, arr, date_dep, date_arr, num_travelers)
        @offers = results[:offers]
        @datalist_flight_segments = results[:datalists][:flight_segments]
        @datalist_passengers = results[:datalists][:passengers]
        @offers_count = @offers.size
        @response = build_response
      end

      def build_response
        template = File.read(TEMPLATE_PATH)
        @method = self.class.to_s.split('::').last
        @message = self
        builder = Nokogiri::XML::Builder.new do
          eval template
        end
        return builder
      end

    end

  end

end
