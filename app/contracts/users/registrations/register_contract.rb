# frozen_string_literal: true

module Users
  module Registrations
    class RegisterContract < ApplicationContract
      params do
        required(:email).filled(Types::Email)
        required(:password).filled(:str?, min_size?: Devise.password_length.min)
      end
    end
  end
end
