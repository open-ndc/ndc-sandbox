require 'pry' if $RACK_ENV == 'development'

require 'active_record'
require 'chronic'

puts "Loading DB config for environment: #{$RACK_ENV}..."
if $RACK_ENV == 'production'
  @config = ENV["DATABASE_URL"]
else
  @config = YAML.load_file('config/database.yml')[$RACK_ENV]
end

if @config.present?
  puts "Connecting DB for environment: #{$RACK_ENV}..."
  ActiveRecord::Base.clear_active_connections!
  ActiveRecord::Base.establish_connection @config
  ActiveRecord::Base.logger = $logger
end
