# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'shoulda/matchers'
require 'mocha/minitest'
require 'minitest/focus'
require 'helpers/form_validator'
require 'helpers/body_parser'
require 'helpers/authentication'
require 'sidekiq/testing'
require 'helpers/sidekiq_minitest_support'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all

  include FactoryBot::Syntax::Methods
  include Helpers::FormValidator
  include Helpers::BodyParser
  include Helpers::Authentication
  include Helpers::SidekiqMinitestSupport
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :minitest
    with.library :rails
  end
end
