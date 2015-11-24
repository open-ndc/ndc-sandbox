require 'active_record'

module Middleware

  class DBConnectionSweeper

    def initialize(app)
      @app = app
      Dir["models/*.rb"].each {|file| require file }
    end

    def call(env)
      response = @app.call(env)
    ensure
      ActiveRecord::Base.clear_active_connections!
      response
    end

  end
end
