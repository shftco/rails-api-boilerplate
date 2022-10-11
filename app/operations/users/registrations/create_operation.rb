# frozen_string_literal: true

module Users
  module Registrations
    class CreateOperation < ApplicationOperation
      option :params
      option :doorkeeper_application, type: Types.Instance(Doorkeeper::Application)
      option :contract, default: proc { Users::Registrations::RegisterContract.new }

      def call
        contract_params = yield validate(contract)
        user = yield call_service(contract_params)

        Success(user)
      end

      private

      def call_service(contract_params)
        Users::Registrations::RegisterService.new(params: contract_params, doorkeeper_application:).call
      end
    end
  end
end
