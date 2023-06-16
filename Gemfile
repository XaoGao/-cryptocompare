# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in cryptocompare.gemspec
gemspec

group :development, :test do
  gem "debug", "~> 1.7", ">= 1.7.1"
  gem "rake", "~> 13.0"
  gem "rubocop", "~> 1.39", require: false
  gem "rubocop-performance", "~> 1.11", require: false
  gem "rubocop-rspec", "~> 2.15", require: false
end

group :test do
  gem "rspec", "~> 3.12"
  gem "simplecov", require: false
  gem "webmock", "~> 3.18", ">= 3.18.1"
end
