module API

  module Messages

    class ServicePriceRQ < API::Messages::Base

      @response_name = "service_price"
      class << self
        attr_reader :response_name
      end

      def initialize(doc)
        super (doc)
        @response = build_response
      end

    end

  end

end
