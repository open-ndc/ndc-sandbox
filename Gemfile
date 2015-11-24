source 'https://rubygems.org'

# ruby '2.2.0'

gem 'json'                          # JSON
gem 'roar'                          # Representer
gem 'foreman'                       # Process management
gem 'rake'
gem 'racksh'
gem 'thin'
gem 'rack-cors', :require => 'rack/cors'
gem 'sprockets'
gem 'sinatra'

# Formatting
gem 'nokogiri'

# DB
gem 'activerecord', '~> 4.0.0'      # Database

# API Framework
gem 'grape'

group :development do
  gem 'rerun'
  gem 'mina' # Deployment
end

group :test do
  gem 'rspec'
  gem 'rack-test'
  gem 'bogus'
  gem 'database_cleaner'
  gem 'timecop'
end

group :development, :test do
  gem 'sqlite3'
  gem 'pry'
  gem 'awesome_print'
end

group :production do
  gem 'pg'
end
