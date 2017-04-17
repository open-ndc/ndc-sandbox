require 'grape'
require 'nokogiri'

desc "Grape API related operations"
namespace :grape do

  desc "List all Grape enabled routes"
  task :routes do
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


