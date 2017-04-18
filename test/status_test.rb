require 'test_helper'
require './api/sandbox_api'

STATUS_URI = '/api/status'


class StatusTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sandbox::API
  end

  test "Gets status OK" do
    header "Content-Type", "application/xml"
    get STATUS_URI
    assert last_response.ok?
  end

end