module API

  module Messages

    class ServiceListRQ < API::Messages::Base

      @response_name = "service_list"
      class << self
        attr_reader :response_name
      end

      attr_reader :services, :bundles

      def initialize(doc)
        super (doc)
        begin
          response_id = @doc.xpath('/ServiceListRQ/ShoppingResponseIDs/ResponseID').text
          od = JSON.parse(ShoppingStore.get_request(response_id))
          routes = Route.fetch_by_ond_and_dates(od["dep"], od["arr"], od["date_dep"]).first
          if routes.present?
            @services = routes.services.load
            @bundles = routes.bundles.load
            @response = build_response
          else
            @errors << API::Messages::Errors::IvalidNDCResponseID.new("ShoppingResponseID found invalid")
          end
        rescue
          @errors << API::Messages::Errors::UnknownNDCProcessingError.new("UnknownNDCProcessingError")
        end
      end

    end
  end

end
