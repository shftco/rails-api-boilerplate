# frozen_string_literal: true

module Doorkeeper
  module AccessTokens
    class CreateService < ApplicationService
      option :doorkeeper_application, type: Types.Instance(Doorkeeper::Application)
      option :user, type: Types.Instance(User)

      def call
        access_token = yield create_resource(Doorkeeper::AccessToken)

        Success(access_token)
      end

      private

      def params
        {
          resource_owner_id: user.id,
          resource_owner_type: user.class.name,
          application_id: doorkeeper_application.id,
          refresh_token: generate_refresh_token,
          expires_in: Doorkeeper.configuration.access_token_expires_in.to_i
        }
      end

      def generate_refresh_token
        loop do
          token = SecureRandom.hex(32)
          break token unless Doorkeeper::AccessToken.exists?(refresh_token: token)
        end
      end
    end
  end
end
