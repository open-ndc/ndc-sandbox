module API

  module Messages

    class AirShoppingRQ < API::Messages::Base

      attr_reader :offers, :offers_count

      TEMPLATE_PATH = "#{File.dirname(__FILE__)}/templates/air_shopping.xml.rb"

      def initialize(doc)
        super (doc)
        doc.remove_namespaces! # Remove namespace to allow easy xpath handling
        ond = doc.xpath('/AirShoppingRQ/CoreQuery/OriginDestinations/OriginDestination').first
        dep = ond.xpath('Departure/AirportCode').text
        arr = ond.xpath('Arrival/AirportCode').text
        date_dep = DateTime.parse(ond.xpath('Departure/Date').text) if ond.xpath('Departure/Date')
        date_arr = DateTime.parse(ond.xpath('Arrival/Date').text) if ond.xpath('Arrival/Date').present?
        num_travelers = doc.xpath('/AirShoppingRQ/Travelers/Traveler/AnonymousTraveler/PTC').first.attributes["Quantity"].value ? doc.xpath('/AirShoppingRQ/Travelers/Traveler/AnonymousTraveler/PTC').first.attributes["Quantity"].value.to_i : nil
        @offers = Offer.fetch_by_ond_and_dates(dep, arr, date_dep, date_arr)
        @offers_count = @offers.size
        @doc = build_response
      end

      def build_response
        template = File.read(TEMPLATE_PATH)
        @method = self.class.to_s.split('::').last
        @message = self
        @@offers_iterator = 0
        builder = Nokogiri::XML::Builder.new do
          eval template
        end
        return builder
      end

      def doc
        @doc
      end

    end

  end

end
