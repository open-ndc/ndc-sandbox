puts "Loading application..."

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'api'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

# Custom global variables

$GLOBAL_OWNER = ENV['GLOBAL_OWNER'] || '--'

require 'boot'

Bundler.require :default, ENV['RACK_ENV']

# Load Persistence DB layer

require './middleware/init_db'
require './middleware/db_connection_sweeper'

# Load Loggers

require './middleware/logger'

# Load App and Grape API
Dir[File.expand_path('../api/*.rb', __FILE__)].each do |f|
  require f
end

require './api/sandbox_api'
require './app/sandbox_app'

# General purpose config

# config.cache_store = :redis_store