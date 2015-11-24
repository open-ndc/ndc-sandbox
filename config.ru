$RACK_ENV = ENV['RACK_ENV'] || 'development'
$APP_ROOT = File.expand_path(File.dirname(__FILE__))

require 'pry'

puts "Starting RackApp with environment (#{$RACK_ENV}) in path (#{$APP_ROOT})"

require File.join(File.dirname(__FILE__), 'init')

use Rack::CommonLogger, $logger
use Middleware::Logger, $logger
use Middleware::DBConnectionSweeper
use ActiveRecord::ConnectionAdapters::ConnectionManagement

require 'rack/cors'
use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: [ :get, :post, :put, :delete, :options ]
  end
end

map "/api" do
  run API::Base
end

map "/" do
  use Rack::Static,
  :root => "./public/",
  :index => 'index.html',
  :header_rules => [[:all, {'Cache-Control' => 'public, max-age=3600'}]]
  run Rack::Static
  run Rack::Directory.new("./public/")
end
