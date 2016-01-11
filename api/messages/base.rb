module API

  module Messages

    class Base

      attr_reader :response, :timestamp, :token, :version, :namespaces, :name, :owner

      def initialize(doc)
        @name = 'OpenNDC Sandbox'
        @version = '1.1.3'
        @owner = 'FA'
        @timestamp = Time.now.utc.iso8601
        @token = Digest::SHA1.hexdigest @timestamp
        @namespaces = {
          'xmlns' => "http://www.iata.org/IATA/EDIST",
          'xmlns:xsi' => "http://www.w3.org/2001/XMLSchema-instance",
        }
        @doc = doc.remove_namespaces! # Remove namespace to allow easy xpath handling
      end

      def response
        @response
      end

      def parse_passengers
        passengers = ond.xpath('Arrival/AirportCode').text
      end

    end

  end

end
