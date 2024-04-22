source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"
gem "rails", "~> 7.0.0"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "jsbundling-rails"
gem "turbo-rails", '~> 1.0.0'
gem "stimulus-rails"
gem "cssbundling-rails"
gem "jbuilder"
gem "redis", "~> 4.0"
gem "rest-client"
gem 'kaminari'
gem 'kaminari-bootstrap', '~> 3.0'
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem "pry-rails"
gem 'aws-sdk-s3', require: false
gem 'simplecov', require: false, group: :test

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "rspec-rails", "~> 6.1.0"
  gem "sqlite3"
end

group :development do  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem "vcr"
  gem "webmock"
end

gem "dockerfile-rails", ">= 1.6", :group => :development
