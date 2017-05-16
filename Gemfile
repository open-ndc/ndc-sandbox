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
gem 'htmlentities', '~> 4.3', '>= 4.3.4'

# DB
gem 'pg'
gem 'activerecord', '~> 4.0.0'      # Database
gem 'redis', '~>3.2'

# API Framework
gem 'grape'

group :development do
  gem 'rb-readline'
  gem 'rerun'
  gem 'mina' # Deployment
end

group :test do
  gem 'test-unit'
  gem "rack-test", require: "rack/test"
  gem 'test_xml'
  gem 'bogus'
  gem 'database_cleaner'
  gem 'timecop'
end

group :development, :test do
  gem 'awesome_print'
  gem 'pry'
end
