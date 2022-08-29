# frozen_string_literal: true

module UsersService
  module Registrations
    class Register < ApplicationService
      include Dry::Monads[:result]
      include Dry::Monads::Do.for(:call)

      include DoorkeeperHelper

      option :params, type: Types::Hash
      option :doorkeeper_application, type: Types.Instance(Doorkeeper::Application)

      def call
        ActiveRecord::Base.transaction(requires_new: true) do
          user = yield create_user
          access_token = yield create_access_token(user)
          response = registration_response(user, access_token)

          Success(response)
        end
      end

      private

      def create_user
        UsersService::Create.new(params:).call
      end

      def create_access_token(user)
        DoorkeeperService::AccessTokens::Create.new(user:, doorkeeper_application:).call
      end
    end
  end
end
