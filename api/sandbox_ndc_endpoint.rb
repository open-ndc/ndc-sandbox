require 'grape'
require 'nokogiri'

SCHEMAS_DIR = "./api/schemas/"
SCHEMAS_VERSION = 'v15-2'

module Sandbox

  module Errors
    class IvalidNDCMessageError < RuntimeError; end
    class IvalidNDCFormatError < RuntimeError; end
    class IvalidNDCValidationError < RuntimeError; end
    class IvalidNDCMessageProcessing < RuntimeError; end
    class UnexpectedNDCResponseError < RuntimeError; end
  end

  class NDCEndpoint < Grape::API

    ACCEPTABLE_NDC_REQUESTS = {
                                AirShoppingRQ: :AirShoppingRS,
                                FlightPriceRQ: :FlightPriceRS,
                                SeatAvailabilityRQ: :SeatAvailabilityRS,
                                ServiceListRQ: :ServiceListRS,
                                ServicePriceRQ: :ServicePriceRS,

                                OrderCreateRQ: :OrderViewRS,
                                OrderListRQ: :OrderListRS,
                                OrderRetrieveRQ: :OrderViewRS,
                                OrderCancelRQ: :OrderCancelRS
                              }

    attr_accessor :message, :ndc_method, :ndc_response_method

    helpers APIHelpers

    before do
      @message = request.env["api.request.input"]
      if !request.post?
        error!("Method not allowed. Try POST", 405)
      elsif @message.blank?
        error!("Malformed Request :: Empty Request Body", 400)
      elsif (@doc = Nokogiri::XML(@message)).root.nil?
        error!("Malformed Request :: XML structure format invalid", 400)
      elsif !ACCEPTABLE_NDC_REQUESTS.include?(@ndc_method = @doc.root.name.to_sym)
        error!("Malformed Request :: Invalid or unrecognized NDC method (#{@ndc_method})", 400)
      else
        errors = []
        @ndc_response_method = ACCEPTABLE_NDC_REQUESTS[@ndc_method]
        schemas_path = SCHEMAS_DIR + SCHEMAS_VERSION
        Dir.chdir(schemas_path) do
          begin
            schema_file = "#{@ndc_method}.xsd"
            xsd = Nokogiri::XML::Schema(File.read(schema_file))
            errors += xsd.validate(@doc)
          rescue => e
            errors << Errors::IvalidNDCValidationError.new("NDC Validation Error(s) :: #{e.message}")
          end
          error!("NDC Validation Error(s) :: #{errors.join(' | ')}", 400) unless errors.empty?
        end
      end
    end

    desc "NDC endpoint supporting all NDC methods"
    post '/ndc' do
      begin
        puts "INFO :: NDC Request: #{@ndc_method.to_s}"
        @message = Sandbox::Messages.class_eval(@ndc_method.to_s).new(@doc)
        if @message.errors.empty? && @message.response.present?
          status 200
        else
          render_ndc_error(@ndc_response_method, @message.errors.first.class, 400, @message.errors.first.message)
        end
      rescue Exception => e
        status 500
        puts "Exception: #{e}"
        raise Errors::UnexpectedNDCResponseError
      else
        if $REQUEST_DELAY
          puts "Adding #{$REQUEST_DELAY} seconds of delay..."
          sleep($REQUEST_DELAY)
        end
        @message.response
      end
    end

  end

end
