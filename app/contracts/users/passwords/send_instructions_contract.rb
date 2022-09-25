# frozen_string_literal: true

module Users
  module Passwords
    class SendInstructionsContract < ApplicationContract
      params do
        required(:email).filled(Types::Email)
        required(:client_id).filled(:string)
        required(:client_secret).filled(:string)
      end
    end
  end
end
