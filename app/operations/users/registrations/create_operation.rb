# frozen_string_literal: true

module Users
  module Registrations
    class CreateOperation < ApplicationOperation
      include Dry::Monads[:result]
      include Dry::Monads::Do.for(:call)

      option :params
      option :doorkeeper_application, type: Types.Instance(Doorkeeper::Application)
      option :contract, default: proc { Users::Registrations::RegisterContract.new }

      def call
        contract_params = yield validate(contract)
        user = yield register_user(contract_params)

        Success(user)
      end

      private

      def register_user(contract_params)
        UsersService::Registrations::Register.new(params: contract_params, doorkeeper_application:).call
      end
    end
  end
end
