module API

  module Messages

    class Error # < API::Messages::Base

      class << self
        # attr_accessor :ndc_method, :ndc_response_method, :error_type, :error_type, :error_message
        attr_reader :response, :timestamp, :token, :version
      end

      TEMPLATES_PATH = "#{File.dirname(__FILE__)}/templates"

      def initialize(ndc_response_method, error_type, error_code, error_message = nil)
        @namespaces = {
          'xmlns' => "http://www.iata.org/IATA/EDIST",
          'xmlns:xsi' => "http://www.w3.org/2001/XMLSchema-instance",
        }
        @ndc_response_method = ndc_response_method
        @error_type = error_type
        @error_code = error_code
        @error_message = error_message
        @response = build_error_response
      end

      def build_error_response
        builder = Nokogiri::XML::Builder.new do |xml|
          xml.send(@ndc_response_method, @namespaces) {
            xml.Errors {
              xml.Error {
                xml.Type_ @error_type
                xml.Code_ @error_code
                xml.Description_ @error_message
              }
            }
          }
        end
        return builder
      end

      def response
        @response
      end

    end

  end

end
