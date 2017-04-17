require 'test_helper'
require './api/sandbox_api'

STATUS_URI = '/api/status'


class StatusTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sandbox::API
  end

  test "The truth" do
    assert true
  end

  # test "Get HOME" do
  #   get '/'
  #   puts "DEBUG ::: last_response -> #{last_response.inspect}"
  #   assert last_response.ok?
  # end


  test "Gets status OK" do
    header "Content-Type", "application/xml"
    get STATUS_URI
    puts "DEBUG ::: last_response -> #{last_response.inspect}"
    assert last_response.ok?
    puts "DEBUG :: GET STATUS TEST RUN"
  end

end


# describe Sandbox::API do
#   include Rack::Test::Methods

#   test "The truth" do
#     assert true
#   end

# end


puts "DEBUG :: STATUS TEST FINISHED!"