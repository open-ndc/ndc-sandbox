require 'test_helper'

STATUS_OK_RESPONSE = <<-XML
  <hash>
    <status>ok</status>
  </hash>
  XML

class StatusTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sandbox::API
  end

  test "Gets status OK" do
    header "Content-Type", "application/xml"
    get STATUS_URI
    assert last_response.ok?
    assert_xml_contain last_response.body, STATUS_OK_RESPONSE
  end

  test "Post status fails" do
    header "Content-Type", "application/xml"
    post STATUS_URI
    assert !last_response.ok?
  end

end