module API

  module Messages

    class Base

      attr_reader :response, :timestamp, :token, :version, :namespaces, :name, :owner

      TEMPLATES_PATH = "#{File.dirname(__FILE__)}/templates"

      def initialize(doc)
        @name = 'OpenNDC Sandbox'
        @version = '15.2'
        @owner = 'FA'
        @timestamp = Time.now.utc.iso8601
        @token = Digest::SHA1.hexdigest @timestamp
        @namespaces = {
          'xmlns' => "http://www.iata.org/IATA/EDIST",
          'xmlns:xsi' => "http://www.w3.org/2001/XMLSchema-instance",
        }
        @doc = doc.remove_namespaces! # Remove namespace to allow easy xpath handling
      end

      def build_response
        template_path = "#{TEMPLATES_PATH}/#{self.class.response_name}.xml.rb"
        template = File.read(template_path)
        @method = self.class.to_s.split('::').last
        @message = self
        builder = Nokogiri::XML::Builder.new do
          eval template
        end
        return builder
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
