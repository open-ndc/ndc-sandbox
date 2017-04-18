$RACK_ENV = ENV['RACK_ENV'] = 'test'

TEMPLATES_PATH = "./test/templates"
API_URL = "/api/ndc/"

require 'grape'

require 'test/unit'
require 'rack/test'
# require 'test_xml/test_unit'

require './middleware/init_db'
require './middleware/db_connection_sweeper'


