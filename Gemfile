# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.2"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem "rack-cors"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]

  # A library for generating fake data [https://github.com/faker-ruby/faker]
  gem "faker", git: "https://github.com/faker-ruby/faker.git", branch: "master"

  # Pretty print your Ruby objects [https://github.com/awesome-print/awesome_print]
  gem "awesome_print"

  # A Ruby static code analyzer and formatter, based on the community Ruby style guide [https://github.com/rubocop/rubocop]
  gem "rubocop", require: false

  # An extension of RuboCop focused on code performance checks [https://github.com/rubocop/rubocop-performance]
  gem "rubocop-performance", require: false

  # A RuboCop extension focused on enforcing Rails best practices and coding conventions [https://github.com/rubocop/rubocop-rails]
  gem "rubocop-rails", require: false

  # Code style checking for Minitest files [https://github.com/rubocop/rubocop-minitest]
  gem "rubocop-minitest", require: false
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  # E-mail opener [https://github.com/ryanb/letter_opener]
  gem "letter_opener", "~> 1.4", ">= 1.4.1"
end

group :test do
  # Making tests easy on the fingers and eyes [https://github.com/thoughtbot/shoulda]
  gem "shoulda", "~> 4.0"

  # Simple one-liner tests for common Rails functionality [https://github.com/thoughtbot/shoulda-matchers#minitest]
  gem "shoulda-matchers", "~> 4.0"

  # A library for setting up Ruby objects as test data. [https://github.com/thoughtbot/factory_bot_rails]
  gem "factory_bot_rails", "~> 6.2"

  # Mocha is a mocking and stubbing library for Ruby [https://github.com/freerange/mocha]
  gem "mocha", "~> 1.13"
end

# Define and serve live-updating Swagger JSON for Ruby apps [https://github.com/fotinakis/swagger-blocks]
gem "swagger-blocks", "~> 3.0"

# Kaminari is a Scope & Engine based customizable and sophisticated paginator [https://github.com/kaminari/kaminari]
gem "kaminari", "~> 1.2", ">= 1.2.2"

# Useful, common monads in idiomatic Ruby [https://github.com/dry-rb/dry-monads]
gem "dry-monads", "~> 1.4"

# Form object decoupled from models with validation, population and presentation [https://github.com/trailblazer/reform]
gem "reform", "~> 2.6"

# Automatically load and include all common Rails form features. [https://github.com/trailblazer/reform-rails]
gem "reform-rails", "~> 0.2.2"

# A simple validation library [https://github.com/dry-rb/dry-validation]
gem "dry-validation", "~> 1.6"

# Flexible authentication solution for Rails with Warden [https://github.com/heartcombo/devise]
gem "devise", "~> 4.8", ">= 4.8.1"

# Doorkeeper is an OAuth 2 provider for Rails and Grape [https://github.com/doorkeeper-gem/doorkeeper/]
gem "doorkeeper", "~> 5.5", ">= 5.5.4"

# Simple, efficient background processing for Ruby []
gem "sidekiq", "~> 6.4", ">= 6.4.1"
