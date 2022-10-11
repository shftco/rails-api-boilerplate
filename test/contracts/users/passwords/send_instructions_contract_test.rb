# frozen_string_literal: true

require 'test_helper'

module Users
  module Passwords
    class SendInstructionsContractTest < ActiveSupport::TestCase
      CONTRACT = Users::Passwords::SendInstructionsContract.new

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
