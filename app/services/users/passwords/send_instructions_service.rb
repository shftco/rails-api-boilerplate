# frozen_string_literal: true

module Users
  module Passwords
    class SendInstructionsService < ApplicationService
      option :params, type: Types::Hash

      def call
        user = yield send_password_instructions
        result = yield check_result(user)

        Success(result)
      end

      private

      def send_password_instructions
        user = User.send_reset_password_instructions(params)

        Success(user)
      end

      def check_result(user)
        return Success(success_message) if successfully_sent?(user)

        resource_failure(user)
      end

      def successfully_sent?(user)
        Devise.paranoid || user.errors.empty?
      end

      def success_message
        { message: I18n.t('devise.passwords.send_instructions') }
      end
    end
  end
end
