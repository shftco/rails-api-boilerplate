# frozen_string_literal: true

require 'dry-validation'

class ApplicationContract < Dry::Validation::Contract
  config.messages.backend = :i18n

  register_macro(:password_confirmation) do
    key.failure(:same_password?) unless values[:password].eql?(values[:password_confirmation])
  end
end
