require 'grape'
require 'nokogiri'

module API

  class XMLMessage < Grape::Validations::Base
  end

  NDC_METHODS = [:AirShopping, :FlightPrice, :SeatAvailability, :ServiceList, :ServicePrice]

  class NDCEndpoint < Grape::API

    before do
      @message = request.env["api.request.input"]
      if request.env["api.request.input"].blank?
        error!("Malformed Request :: Empty Body", 400)
      elsif (@doc = Nokogiri::XML(@message)).root.nil?
        error!("Malformed Request :: XML structure format invalid", 400)
      elsif !NDC_METHODS.include?(@ndc_method = @doc.root.name.to_sym)
        error!("Malformed Request :: Invalid or unrecognized NDC method (#{@ndc_method})", 400)
      end
    end

    desc "NDC endpoint supporting all NDC methods"
    post '/ndc' do
      present NDC: true
    end

  end

end
