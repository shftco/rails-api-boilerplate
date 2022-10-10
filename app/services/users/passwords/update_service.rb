# frozen_string_literal: true

module Users
  module Passwords
    class UpdateService < ApplicationService
      option :params, type: Types::Hash

      def call
        user = yield update_password
        result = yield check_result(user)

        Success(result)
      end

      private

      def update_password
        user = User.reset_password_by_token(params)

        Success(user)
      end

      def check_result(user)
        return Success(success_message) if successfully_updated?(user)

        resource_failure(user)
      end

      def successfully_updated?(user)
        user.errors.empty?
      end

      def success_message
        { message: I18n.t('devise.passwords.updated_not_active') }
      end
    end
  end
end
