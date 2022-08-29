# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'shoulda/matchers'
require 'minitest/unit'
require 'mocha/minitest'
require 'minitest/focus'
require 'supports/contract_validator'
require 'supports/body_parser'
require 'supports/contract_parser'
require 'supports/doorkeeper_authenticator'
require 'supports/sidekiq_minitest_support'
require 'sidekiq/testing'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  # parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all

  include FactoryBot::Syntax::Methods
  include Supports::BodyParser
  include Supports::ContractParser
  include Supports::ContractValidator
  include Supports::DoorkeeperAuthenticator
  include Supports::SidekiqMinitestSupport
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :minitest
    with.library :rails
  end
end
