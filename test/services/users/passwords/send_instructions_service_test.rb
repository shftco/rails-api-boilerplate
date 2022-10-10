# frozen_string_literal: true

require 'test_helper'

module Users
  module Passwords
    class SendInstructionsServiceTest < ActiveSupport::TestCase
      attr_reader :user

      def setup
        @user = create(:user)
      end

      test 'should send instructions to user' do
        params = { email: user.email }

        assert_changes -> { user.updated_at } do
          service = Users::Passwords::SendInstructionsService.new(params:).call

          user.reload

          assert service.success?
          assert_equal I18n.t('devise.passwords.send_instructions'), service.success[:message]
        end
      end

      test 'should not update password if token is invalid' do
        params = { email: 'test@development.com' }

        assert_no_changes -> { user.updated_at } do
          service = Users::Passwords::SendInstructionsService.new(params:).call

          user.reload

          assert service.failure?
        end
      end
    end
  end
end
