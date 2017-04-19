require 'pry' if $RACK_ENV == 'development'

require 'active_record'
require 'chronic'
require 'yaml'

if !ENV['DATABASE_URL'].nil?
  puts "Loading DB config from environment variable ENV['DATABASE_URL']: #{ENV['DATABASE_URL']}..."
  @config = ENV["DATABASE_URL"]
else
  puts "Loading DB config from database.yml (environment: #{$RACK_ENV})..."
  @config = YAML.load_file('config/database.yml')[$RACK_ENV]
end

if @config.present?
  puts "Connecting DB..."
  ActiveRecord::Base.clear_active_connections!
  ActiveRecord::Base.establish_connection @config
  ActiveRecord::Base.logger = $logger
end

# Load all models in models/ dir
puts "Loading models..."
Dir["./models/*.rb"].each {|file| require file }