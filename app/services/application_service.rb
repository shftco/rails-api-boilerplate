# frozen_string_literal: true

require 'dry/monads/all'
require 'dry-initializer'

class ApplicationService
  extend Dry::Initializer

  include Dry::Monads
  include Dry::Monads::Do
  include Supports::Sidekiq::Helper
  include Supports::ApplicationService::Helper
end
