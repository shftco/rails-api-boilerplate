# frozen_string_literal: true

module UsersService
  module Registration
    class Register < ApplicationService
      include Dry::Monads[:result]
      include Dry::Monads::Do.for(:call)

      option :params, type: Types::Hash

      def call
        ActiveRecord::Base.transaction(requires_new: true) do
          user = yield call_create_user

          Success(user)
        end
      end

      private

      def call_create_user
        UsersService::Create.new(params:).call
      end
    end
  end
end
