# frozen_string_literal: true

module Users
  module Passwords
    class SendInstructionsContract < ApplicationContract
      params do
        required(:email).filled(Types::Email)
      end
    end
  end
end
