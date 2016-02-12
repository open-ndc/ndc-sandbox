source 'https://rubygems.org'

<<<<<<< HEAD
ruby '2.2.0'
=======
ruby ENV['CUSTOM_RUBY_VERSION'] || "2.2.0"
>>>>>>> 3dd0e1ea9663b056fb5ae40158f18cf99a24cdab

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

group :development do
  gem 'rb-readline'
  gem 'byebug'
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
  gem 'awesome_print'
  gem 'pry'
end

group :production do
  gem 'pg'
end
