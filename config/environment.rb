puts "Loading environment..."

ENV['RACK_ENV'] ||= 'development'

$GLOBAL_OWNER = ENV['GLOBAL_OWNER'] || '--'
$REQUEST_DELAY = ENV['REQUEST_DELAY'].to_i if ENV['REQUEST_DELAY']


require File.expand_path('../application', __FILE__)