ENV['APP_ENV'] ||= 'test'

TEMPLATES_PATH = "./test/templates"
API_URL = "/api/ndc/"

require 'grape'

require 'test/unit'
require 'rack/test'
# require 'rspec/core'
# require 'minitest/autorun'
# require 'test_xml/spec'


# map "/api" do
#   run Sandbox::API
# end

