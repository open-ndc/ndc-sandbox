# Rakefile
require 'bundler/setup'

$RACK_ENV = ENV['RACK_ENV'] || 'development'
$APP_ROOT = File.expand_path(File.dirname(__FILE__))

if $RACK_ENV == 'test'
  require 'rspec/core'
  require "rspec/core/rake_task"
  RSpec::Core::RakeTask.new(:spec)
end

require 'yaml'
require 'logger'
require 'pry' if $RACK_ENV == 'development'

Dir.glob("#{$APP_ROOT}/lib/core_ext/*.rb").each { |r| import r }

Dir[File.join($APP_ROOT, 'lib', 'tasks', '**', '*.rake')].each do |file|
  load file
end
