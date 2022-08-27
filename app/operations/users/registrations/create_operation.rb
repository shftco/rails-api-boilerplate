# frozen_string_literal: true

module Users
  module Registrations
    class CreateOperation < ApplicationOperation
      include Dry::Monads[:result]
      include Dry::Monads::Do.for(:call)

      option :params
      option :contract, default: proc { Users::RegistrationContract.new }

      def call
        contract_params = yield validate(contract)
        user = yield register_user(contract_params)

        Success(user)
      end

      private

      def register_user(contract_params)
        UsersService::Registration::Register.new(params: contract_params).call
      end
    end
  end
end
