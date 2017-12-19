$RACK_ENV = ENV['RACK_ENV'] || 'development'
$APP_ROOT = File.expand_path(File.dirname(__FILE__))

require 'rubygems'
require 'bundler'

def load_path(path)
  File.join($APP_ROOT, path)
end

$LOAD_PATH << load_path(".")
$LOAD_PATH << load_path("./lib")

puts "Starting RackApp with environment (#{$RACK_ENV}) in path (#{$APP_ROOT})"

Dir.glob("#{$APP_ROOT}/lib/core_ext/*.rb").each { |ext| require ext }

# DBs
require File.join(File.dirname(__FILE__), './middleware/init_db')
require 'middleware/db_connection_sweeper'
require 'middleware/connection_management'
use Middleware::DBConnectionSweeper
use Middleware::ConnectionManagement

# Loggers
require 'middleware/logger'
require 'logger'

$logger = ::Logger.new(STDOUT)

class ::Logger; alias_method :write, :<<; end # for Rack::CommonLogger
use Rack::CommonLogger, $logger
use Middleware::Logger, $logger

require File.expand_path('../config/environment', __FILE__)

run Sandbox::App.instance
