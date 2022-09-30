# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
ruby(File.read(File.join(File.dirname(__FILE__), '.ruby-version')).strip)

gem 'activeadmin', '~> 2.13.1'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'carrierwave', '~> 2.0'
gem 'coderay', '~> 1.1.3'
gem 'country_select', '~> 8.0.0'
gem 'devise', '~> 4.8.1'
gem 'draper', '~> 4.0.0'
gem 'factory_bot_rails', '~>6.2.0'
gem 'ffaker', '~> 2.21.0'
gem 'figaro', '~> 1.2.0'
gem 'fog-aws', '~> 3.15.0'
gem 'haml-rails', '~> 2.0'
gem 'html2haml', '~> 2.2.0'
gem 'omniauth', '~> 2.1.0'
gem 'omniauth-google-oauth2', '~> 1.1.1'
gem 'omniauth-rails_csrf_protection', '~> 1.0'
gem 'pagy', '~> 5.10'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.6', '>= 6.1.6.1'
gem 'redcarpet', '~> 3.5.1'
gem 'sass-rails', '>= 6'
gem 'simple_form', '~> 5.1.0'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'

group :development, :test do
  gem 'bullet', '~> 7.0.3'
  gem 'database_consistency', '~> 1.1.15', require: false
  gem 'lefthook', '~> 1.1.1'
  gem 'pry-rails', '~> 0.3.9'
  gem 'rubocop', '~> 1.34.0', require: false
  gem 'rubocop-performance', '~> 1.14.3', require: false
  gem 'rubocop-rails', '~> 2.15.2', require: false
  gem 'rubocop-rspec', '~> 2.12.1', require: false
end

group :development do
  gem 'brakeman', '~> 5.3.1'
  gem 'bundler-audit', '~> 0.9.1'
  gem 'fasterer', '~> 0.10.0'
  gem 'letter_opener', '~> 1.8.1'
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring', '~> 4.0.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'faker', '~> 2.22.0'
  gem 'rails-controller-testing', '~> 0.0.3'
  gem 'rspec-rails', '~> 5.1.2'
  gem 'selenium-webdriver', '>= 4.0.0.rc1'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'simplecov', '~> 0.21.2', require: false
  gem 'webdrivers', '~> 5.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
