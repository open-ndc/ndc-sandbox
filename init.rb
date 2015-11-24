def load_path(path)
  File.join($APP_ROOT, path)
end

$LOAD_PATH << load_path(".")
$LOAD_PATH << load_path("./lib")

require 'api/api_base'
require 'middleware/db_connection_sweeper'
require 'middleware/logger'
require 'logger'

class ::Logger; alias_method :write, :<<; end # for Rack::CommonLogger

# $LOG_FILE = "./log/#{$RACK_ENV}.log"
puts "Initializing logfile in: #{STDOUT}"
$logger = ::Logger.new(STDOUT)

puts "Connecting DB for environment: #{$RACK_ENV}..."
if $RACK_ENV == 'production'
  @config = ENV["DATABASE_URL"]
else
  @config = YAML.load_file('config/database.yml')[$RACK_ENV]
end

if @config.present?
  ActiveRecord::Base.establish_connection @config
  ActiveRecord::Base.logger = $logger
end
