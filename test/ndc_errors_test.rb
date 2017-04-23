require 'test_helper'

class NDCErrorsTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sandbox::API
  end

  EMPTY_REQUEST_ERROR_MESSAGE = <<-XML
    <message>Malformed Request :: Empty Request Body</message>
  XML

  INVALID_REQUEST_ERROR_MESSAGE = <<-XML
    <message>Malformed Request :: Invalid or unrecognized NDC method (Wadus)</message>
  XML

  test "Post empty fails" do
      header "Content-Type", "application/xml"
      post API_URL
      assert !last_response.ok?
      assert last_response.status == 400
      assert_xml_structure_contain last_response.body, EMPTY_REQUEST_ERROR_MESSAGE
  end

  test "Post NDC invalid fails" do
      header "Content-Type", "application/xml"
      post API_URL, "<Wadus>Wadus</Wadus>"
      assert !last_response.ok?
      assert last_response.status == 400
      assert_xml_structure_contain last_response.body, INVALID_REQUEST_ERROR_MESSAGE
  end

end
