# frozen_string_literal: true

module V1
  module UsersContract
    module Passwords
      class SendInstructions < ApplicationContract
        params do
          required(:email).filled(Types::Email)
        end
      end
    end
  end
end
