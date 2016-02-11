module API

  module Messages

    class ServiceListRQ < API::Messages::Base
      require "redis"
      require "byebug"

      @response_name = "service_list"
      class << self
        attr_reader :response_name
      end

      attr_reader :services, :bundles

      def initialize(doc)
        super (doc)
        response_id = @doc.xpath('/ServiceListRQ/ShoppingResponseIDs/ResponseID').text
        od = JSON.parse(get_request(response_id))
        routes = Route.fetch_by_ond_and_dates(od["dep"], od["arr"], od["date_dep"]).first
        @services = routes.services.load
        @bundles = routes.bundles.load
        byebug
        @response = build_response
      end

      def get_request(response_id)
        Redis.current.get(response_id)
      end
    end

  end

end
