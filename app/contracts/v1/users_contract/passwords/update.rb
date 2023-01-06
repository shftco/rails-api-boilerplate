# frozen_string_literal: true

module V1
  module UsersContract
    module Passwords
      class Update < ApplicationContract
        params do
          required(:reset_password_token).filled(:string)
          required(:password) { filled? & str? & min_size?(Devise.password_length.min) }
          required(:password_confirmation) { filled? & str? & min_size?(Devise.password_length.min) }
        end

        rule(:password).validate(:password_confirmation)
        rule(:password_confirmation).validate(:password_confirmation)
      end
    end
  end
end
