# frozen_string_literal: true

module V1
  module Users
    class TokensController < Doorkeeper::TokensController
      private

      def revocation_error_response
        error_description = I18n.t('doorkeeper.errors.messages.revoke.unauthorized')

        { errors: [error_description] }
      end
    end
  end
end
