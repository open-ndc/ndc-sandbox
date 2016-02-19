source 'https://rubygems.org'

ruby '2.2.2'

gem 'json'                          # JSON
gem 'foreman'                       # Process management
gem 'racksh'
gem 'thin'
gem 'rack-cors', :require => 'rack/cors'
gem 'sprockets'
gem 'rake'

# Formatting
gem 'nokogiri'
gem 'chronic'

# DB
gem 'activerecord', '~> 4.0.0'      # Database
gem 'redis', '~>3.2'

# API Framework
gem 'grape'

gem 'test-unit'
gem 'minitest'

# DB
gem 'pg'

group :development do
  gem 'rb-readline'
  gem 'rerun'
  gem 'mina' # Deployment
end

group :test do
  gem 'bogus'
  gem 'database_cleaner'
  gem 'timecop'
end

group :development, :test do
  gem 'awesome_print'
  gem 'pry'
end
