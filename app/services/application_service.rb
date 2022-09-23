# frozen_string_literal: true

require 'dry/monads/all'
require 'dry-initializer'

class ApplicationService
  extend Dry::Initializer

  include Dry::Monads
  include Dry::Monads::Do
  include Supports::Sidekiq::Helper

  def resource_failure(resource)
    custom_resource_failure(resource.errors.full_messages)
  end

  def custom_resource_failure(errors)
    Failure({ errors: })
  end
end
