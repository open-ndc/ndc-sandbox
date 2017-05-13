require 'test_helper'

class NDCErrorsTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sandbox::API
  end

  WRONG_METHOD_ERROR_MESSAGE = <<-XML
  <error>
    <message>GET Method is not allowed. Send POST</message>
  </error>
  XML

  EMPTY_REQUEST_ERROR_MESSAGE = <<-XML
  <error>
    <message>Malformed Request :: Empty Request Body</message>
  </error>
  XML

  INVALID_REQUEST_ERROR_MESSAGE = <<-XML
  <error>
    <message>Malformed Request :: Invalid or unrecognized NDC method (Wadus)</message>
  </error>
  XML

  INVALID_AIRSHOPPING_ERROR_MESSAGE = <<-XML
  <error>
    <message>Malformed Request :: Invalid or unrecognized NDC method (AirShopping)</message>
  </error>
  XML

  test "GET request fails" do
      header "Content-Type", "application/xml"
      get API_URL
      assert !last_response.ok?
      assert last_response.status == 405
      assert_xml_contain last_response.body, WRONG_METHOD_ERROR_MESSAGE
  end


  test "Post empty fails" do
      header "Content-Type", "application/xml"
      post API_URL
      assert !last_response.ok?
      assert last_response.status == 400
      assert_xml_contain last_response.body, EMPTY_REQUEST_ERROR_MESSAGE
  end

  test "Post NDC invalid fails" do
      header "Content-Type", "application/xml"
      post API_URL, "<Wadus>Wadus</Wadus>"
      assert !last_response.ok?
      assert last_response.status == 400
      assert_xml_contain last_response.body, INVALID_REQUEST_ERROR_MESSAGE
  end

  test "Post invalid NDC AirShopping fails" do
      header "Content-Type", "application/xml"
      post API_URL, "<AirShopping>Wadus</AirShopping>"
      assert !last_response.ok?
      assert last_response.status == 400
      assert_xml_contain last_response.body, INVALID_AIRSHOPPING_ERROR_MESSAGE
  end

end
