# frozen_string_literal: true

module V1
  module UsersContract
    module Registrations
      class Register < ApplicationContract
        params do
          required(:email).filled(Types::Email)
          required(:password).filled(:str?, min_size?: Devise.password_length.min)
        end
      end
    end
  end
end