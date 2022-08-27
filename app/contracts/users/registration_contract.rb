# frozen_string_literal: true

module Users
  class RegistrationContract < ApplicationContract
    params do
      required(:email).filled(Types::Email)
      required(:password).filled(:str?, min_size?: Devise.password_length.min)
    end
  end
end
