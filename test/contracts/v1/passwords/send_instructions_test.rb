# frozen_string_literal: true

require 'test_helper'

module V1
  module UsersContract
    module Passwords
      class SendInstructionsTest < ActiveSupport::TestCase
        CONTRACT = V1::UsersContract::Passwords::SendInstructions.new

        def validate(payload = {})
          CONTRACT.call(payload)
        end

        test 'validate#email' do
          success?(validate({ email: 'test@test.com' }), :email, CONTRACT)
          filled?(validate({ email: nil }), :email, CONTRACT)
          filled?(validate({ email: '' }), :email, CONTRACT)
          format?(validate({ email: 'invalid email' }), :email, CONTRACT)
        end
      end
    end
  end
end
