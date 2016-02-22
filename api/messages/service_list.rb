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
          od_hash = ShoppingStore.get_request(response_id)
          unless od_hash.present?
            @errors << API::Messages::Errors::IvalidNDCResponseID.new("ShoppingResponseID is invalid")
          end
          od = JSON.parse(od_hash)
          routes = Route.fetch_by_ond_and_dates(od["dep"], od["arr"], od["date_dep"]).first
          if routes.present?
            @services = routes.services.load
            @bundles = routes.bundles.load
            @response = build_response
          else
            @errors << API::Messages::Errors::RouteNotFound.new("Unable to find route")
          end
        rescue => error
          @errors << API::Messages::Errors::UnknownNDCProcessingError.new("UnknownNDCProcessingError: #{error}")
        end
      end

    end
  end

end
