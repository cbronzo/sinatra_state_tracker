source 'http://rubygems.org'

gem 'sinatra'
gem 'activerecord'
gem 'sinatra-activerecord'
gem 'rake'
gem 'rack-flash3'
gem 'require_all'
gem 'thin'
gem 'shotgun'
gem 'bcrypt'
gem "tux"

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'pry'
  gem 'sqlite3'
end

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'rack-test'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'
end
