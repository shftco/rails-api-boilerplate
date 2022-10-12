# frozen_string_literal: true

require 'dry/monads/all'
require 'dry-initializer'

class ApplicationOperation
  extend Dry::Initializer

  include Dry::Monads
  include Dry::Monads::Do
  include Supports::ApplicationOperation::Helper
  include Supports::ApplicationContract::ErrorParser
end
