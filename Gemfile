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
# gem "jbuilder"

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
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  # A Ruby static code analyzer and formatter, based on the community Ruby style guide [https://github.com/rubocop/rubocop]
  gem "rubocop", require: false

  # An extension of RuboCop focused on code performance checks [https://github.com/rubocop/rubocop-performance]
  gem "rubocop-performance", require: false

  # A RuboCop extension focused on enforcing Rails best practices and coding conventions [https://github.com/rubocop/rubocop-rails]
  gem "rubocop-rails", require: false

  # Code style checking for Minitest files [https://github.com/rubocop/rubocop-minitest]
  gem "rubocop-minitest", require: false

  # E-mail opener [https://github.com/ryanb/letter_opener]
  gem "letter_opener", "~> 1.4", ">= 1.4.1"
end
