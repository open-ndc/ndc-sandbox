# Rakefile
require 'bundler/setup'

$RACK_ENV = ENV['RACK_ENV'] || 'development'
$APP_ROOT = File.expand_path(File.dirname(__FILE__))

require 'yaml'
require 'logger'
require 'pry' if $RACK_ENV == 'development'

Dir.glob("#{$APP_ROOT}/lib/core_ext/*.rb").each { |r| import r }

Dir[File.join($APP_ROOT, 'lib', 'tasks', '**', '*.rake')].each do |file|
  puts "Rake :: Loading rake file (#{file})..."
  load file
end
