# frozen_string_literal: true

module Users
  module Registrations
    class RegisterContract < ApplicationContract
      params do
        required(:email).filled(Types::Email)
        required(:password).filled(:str?, min_size?: Devise.password_length.min)
        required(:client_id).filled(:string)
        required(:client_secret).filled(:string)
      end
    end
  end
end
