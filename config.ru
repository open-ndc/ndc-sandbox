$RACK_ENV = ENV['RACK_ENV'] || 'development'
$APP_ROOT = File.expand_path(File.dirname(__FILE__))
$GLOBAL_OWNER = ENV['GLOBAL_OWNER'] || '--'
$REQUEST_DELAY = ENV['REQUEST_DELAY'].to_i if ENV['REQUEST_DELAY']

# require 'rubygems'
# require 'bundler'

# def load_path(path)
#   File.join($APP_ROOT, path)
# end

# $LOAD_PATH << load_path(".")
# $LOAD_PATH << load_path("./lib")

# puts "Starting RackApp with environment (#{$RACK_ENV}) in path (#{$APP_ROOT})"

# Dir.glob("#{$APP_ROOT}/lib/core_ext/*.rb").each { |ext| require ext }

# require File.join(File.dirname(__FILE__), 'init_db')
# require 'api/api_base'
# require 'middleware/db_connection_sweeper'
# require 'middleware/logger'
# require 'logger'

# class ::Logger; alias_method :write, :<<; end # for Rack::CommonLogger

# puts "Initializing logfile in: #{STDOUT}"
# $logger = ::Logger.new(STDOUT)

# use Rack::CommonLogger, $logger
# use Middleware::Logger, $logger
# use Middleware::DBConnectionSweeper
# use ActiveRecord::ConnectionAdapters::ConnectionManagement

# require 'rack/cors'
# use Rack::Cors do
#   allow do
#     origins '*'
#     resource '*', headers: :any, methods: [ :get, :post, :put, :delete, :options ]
#   end
# end

# map "/api" do
#   run Sandbox::API
# end

# map "/" do
#   use Rack::Static,
#   :root => "./public/",
#   :index => 'index.html',
#   :header_rules => [[:all, {'Cache-Control' => 'public, max-age=3600'}]]
#   run Rack::Static
#   run Rack::Directory.new("./public/")
# end

require File.expand_path('../config/environment', __FILE__)

run Sandbox::App.instance