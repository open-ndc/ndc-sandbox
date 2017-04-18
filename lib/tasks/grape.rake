require 'grape'
require 'nokogiri'

desc "Grape API related operations"
namespace :grape do

  task :environment do
    # Load App and Grape API for grape access
    Dir[File.expand_path('../api/*.rb', __FILE__)].each do |f|
      require f
    end
    require './api/sandbox_api'
    require './app/sandbox_app'
  end

  desc "List all Grape enabled routes"
  task :routes => :environment do
    routes = Sandbox::API.routes.collect { |r| {
                                                route: {
                                                 version: r.instance_variable_get(:@options)[:version],
                                                 method: r.instance_variable_get(:@options)[:method],
                                                 path: r.instance_variable_get(:@options)[:path],
                                                }
                                               }
                                          }
    puts routes
  end

end


