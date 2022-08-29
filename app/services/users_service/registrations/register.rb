# frozen_string_literal: true

module UsersService
  module Registrations
    class Register < ApplicationService
      include Dry::Monads[:result]
      include Dry::Monads::Do.for(:call)

      option :params, type: Types::Hash

      def call
        user = yield create_user

        Success(user)
      end

      private

      def create_user
        UsersService::Create.new(params:).call
      end
    end
  end
end
