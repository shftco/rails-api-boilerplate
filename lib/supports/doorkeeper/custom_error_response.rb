# frozen_string_literal: true

# https://github.com/doorkeeper-gem/doorkeeper/blob/main/lib/doorkeeper/oauth/error_response.rb
module Supports
  module Doorkeeper
    module CustomErrorResponse
      def body
        {
          errors: custom_errors
        }
      end

      def status
        if @error.name == :invalid_client || @error.name == :unauthorized_client
          :unauthorized
        else
          :bad_request
        end
      end

      private

      def custom_errors
        [
          if @error.name == :invalid_client || @error.name == :unauthorized_client
            I18n.t('doorkeeper.errors.messages.invalid_client')
          else
            I18n.t('devise.failure.invalid', authentication_keys: User.authentication_keys.join('/'))
          end
        ]
      end
    end
  end
end
