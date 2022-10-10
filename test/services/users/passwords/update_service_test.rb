# frozen_string_literal: true

require 'test_helper'

module Users
  module Passwords
    class UpdateServiceTest < ActiveSupport::TestCase
      attr_reader :user

      def setup
        @user = create(:user)
      end

      test 'should update password successfully' do
        reset_password_token = user.send_reset_password_instructions

        params = { reset_password_token:,
                   password: '123456',
                   password_confirmation: '123456' }

        assert_changes -> { user.updated_at } do
          service = Users::Passwords::UpdateService.new(params:).call

          user.reload

          assert service.success?
          assert_equal I18n.t('devise.passwords.updated_not_active'), service.success[:message]
        end
      end

      test 'should not update password if token is invalid' do
        params = { reset_password_token: 'invalid',
                   password: '123456',
                   password_confirmation: '123456' }

        assert_no_changes -> { user.updated_at } do
          service = Users::Passwords::UpdateService.new(params:).call

          user.reload

          assert service.failure?
        end
      end
    end
  end
end
