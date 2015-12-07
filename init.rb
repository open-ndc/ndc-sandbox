require 'pry' if $RACK_ENV == 'development'

require 'active_record'
require 'chronic'

class ::Logger; alias_method :write, :<<; end # for Rack::CommonLogger

# $LOG_FILE = "./log/#{$RACK_ENV}.log"
puts "Initializing logfile in: #{STDOUT}"
$logger = ::Logger.new(STDOUT)


puts "Loading DB config for environment: #{$RACK_ENV}..."
if $RACK_ENV == 'production'
  @config = ENV["DATABASE_URL"]
else
  @config = YAML.load_file('config/database.yml')[$RACK_ENV]
end
puts "Config loaded: #{@config.inspect}"

if @config.present?
  puts "Connecting DB for environment: #{$RACK_ENV}..."
  ActiveRecord::Base.clear_active_connections!
  ActiveRecord::Base.establish_connection @config
  ActiveRecord::Base.logger = $logger
end
