require 'grape'
require 'nokogiri'

SCHEMAS_DIR = "./api/schemas/"
SCHEMAS_VERSION = 'v113-p15-2'

module API

  module Errors
    class IvalidNDCMessageError < RuntimeError; end
    class IvalidNDCValidationError < RuntimeError; end
    class IvalidNDCFormatError < RuntimeError; end
  end

  NDC_METHODS = [:AirShoppingRQ, :FlightPriceRQ, :SeatAvailabilityRQ, :ServiceListRQ, :ServicePriceRQ]

  class NDCEndpoint < Grape::API

    helpers APIHelpers

    before do
      @message = request.env["api.request.input"]
      if request.env["api.request.input"].blank?
        error!("Malformed Request :: Empty Body", 400)
      elsif (@doc = Nokogiri::XML(@message)).root.nil?
        error!("Malformed Request :: XML structure format invalid", 400)
      elsif !NDC_METHODS.include?(@ndc_method = @doc.root.name.to_sym)
        error!("Malformed Request :: Invalid or unrecognized NDC method (#{@ndc_method})", 400)
      else
        errors = []
        schemas_path = SCHEMAS_DIR + SCHEMAS_VERSION
        Dir.chdir(schemas_path) do
          begin
            schema_file = "#{@ndc_method}.xsd"
            xsd = Nokogiri::XML::Schema(File.read(schema_file))
            errors += xsd.validate(@doc)
          rescue => e
            errors << Errors::IvalidNDCValidationError.new("NDC Validation Error :: #{e.message}")
          end
          error!("Malformed NDC message :: #{errors.join(' | ')}", 400) unless errors.empty?
        end
      end
    end

    desc "NDC endpoint supporting all NDC methods"
    post '/ndc' do
      @message = API::Messages.class_eval(@ndc_method.to_s).new(@doc)
      status 200
      @message.response
    end

  end

end
