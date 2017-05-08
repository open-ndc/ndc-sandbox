require 'test_helper'

AIRSHOPPING_SUCCESS = <<-XML
  <AirShoppingRS>
    <Success/>
  </AirShoppingRS>
XML

AIRSHOPPING_SHOPPING_RESPONSE_IDS = <<-XML
  <AirShoppingRS>
    <ShoppingResponseIDs>
      <ResponseID></ResponseID>
    </ShoppingResponseIDs>
  </AirShoppingRS>
XML

class AirShoppingTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sandbox::API
  end

  setup do
    @method = :AirShopping
    @message = File.read("#{TEMPLATES_PATH}/#{@method.to_s}RQ.xml")
    @wrong_message = File.read("#{TEMPLATES_PATH}/#{@method.to_s}RQ-wrong.xml")
  end

  test "Post valid AirShopping gets OK" do
    header "Content-Type", "application/xml"
    post API_URL, @message
    assert last_response.ok?
    assert_xml_contain last_response.body, AIRSHOPPING_SUCCESS
    assert_xml_structure_contain last_response.body, AIRSHOPPING_SHOPPING_RESPONSE_IDS
  end

  test "Post invalid AirShopping gets OK" do
    header "Content-Type", "application/xml"
    post API_URL, @wrong_message
    assert !last_response.ok?
    assert_xml_structure_contain last_response.body, RESPONSE_ERROR
  end

end
