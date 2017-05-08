$RACK_ENV = ENV['RACK_ENV'] = 'test'

TEMPLATES_PATH = "./test/templates"
STATUS_URI = '/api/status'
API_URL = "/api/ndc/"

Dir.glob("./lib/core_ext/*.rb").each { |ext| 
  require ext 
}

require 'grape'

require 'test/unit'
require 'rack/test'
require 'test_xml/test_unit'

require './middleware/init_db'
require './middleware/db_connection_sweeper'

require './api/sandbox_api'

# XML general patterns

RESPONSE_ERROR = <<-XML
  <error/>
XML


