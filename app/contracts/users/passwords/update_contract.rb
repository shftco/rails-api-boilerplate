# frozen_string_literal: true

module Users
  module Passwords
    class UpdateContract < ApplicationContract
      params do
        required(:reset_password_token).filled(:string)
        required(:password) { filled? & str? & min_size?(Devise.password_length.min) }
        required(:password_confirmation) { filled? & str? & min_size?(Devise.password_length.min) }
        required(:client_id).filled(:string)
        required(:client_secret).filled(:string)
      end

      rule(:password).validate(:password_confirmation)
      rule(:password_confirmation).validate(:password_confirmation)
    end
  end
end
