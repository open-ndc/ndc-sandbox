module Sandbox

  module APIHelpers

    def render_ndc_error(ndc_response_method, error_type, error_code, error_description = nil)
      status error_code
      @message = API::Messages::Error.new(ndc_response_method, error_type, error_code, error_description)
      @message.response.doc.to_xml
    end

  end

end
