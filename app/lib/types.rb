# frozen_string_literal: true

require 'dry-types'

module Types
  include Dry.Types()

  Email = String.constrained(format: URI::MailTo::EMAIL_REGEXP)
end
