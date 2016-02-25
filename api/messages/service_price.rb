module API

  module Messages

    class ServicePriceRQ < API::Messages::Base

      @response_name = "service_price"
      class << self
        attr_reader :response_name
      end

      attr_reader :services, :num_travelers

      def initialize(doc)
        super (doc)
        begin
          response_id = @doc.xpath('/ServicePriceRQ/ShoppingResponseIDs/ResponseID').text
          @services = Service.get_services(response_id)
          @num_travelers = ShoppingStore.get_num_travelers(response_id)
          @response = build_response
        rescue => error
          @errors << API::Messages::Errors::UnknownNDCProcessingError.new("UnknownNDCProcessingError: #{error}")
        end
      end
    end

  end

end
