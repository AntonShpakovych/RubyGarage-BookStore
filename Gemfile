# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
ruby(File.read(File.join(File.dirname(__FILE__), '.ruby-version')).strip)

gem 'bootsnap', '>= 1.4.4', require: false
gem 'haml-rails', '~> 2.0'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.6', '>= 6.1.6.1'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'

group :development, :test do
  gem 'draper', '~> 4.0.0'
  gem 'faker', :git => 'https://github.com/faker-ruby/faker.git', :branch => 'master'
  gem 'pagy', '~> 5.10'
  gem 'rails-controller-testing', '~> 0.0.3'
  gem 'rspec-rails', '~> 5.1.2'
  gem 'rubocop', '~> 1.34.0', require: false
  gem 'rubocop-performance', '~> 1.14.3', require: false
  gem 'rubocop-rails', '~> 2.15.2', require: false
  gem 'rubocop-rspec', '~> 2.12.1', require: false
end

group :development do
  gem 'factory_bot_rails', '~>6.2.0'
  gem 'fasterer', '~> 0.10.0'
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring', '~> 4.0.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'database_cleaner-active_record'
  gem 'selenium-webdriver', '>= 4.0.0.rc1'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'simplecov', '~> 0.21.2', require: false
  gem 'webdrivers', '~> 5.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
