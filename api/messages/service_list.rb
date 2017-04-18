module Sandbox

  module Messages

    class ServiceListRQ < Sandbox::Messages::Base

      @response_name = "service_list"
      class << self
        attr_reader :response_name
      end

      attr_reader :services, :bundles

      def initialize(doc)
        super (doc)
        begin
          response_id = @doc.xpath('/ServiceListRQ/ShoppingResponseIDs/ResponseID').text
          @services = Service.get_services(response_id)
          @bundles = Bundle.get_bundles(response_id)
          @response = build_response
        rescue => error
          @errors << Sandbox::Messages::Errors::UnknownNDCProcessingError.new("UnknownNDCProcessingError: #{error}")
        end
      end
    end

  end

end
