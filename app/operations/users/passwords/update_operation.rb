# frozen_string_literal: true

module Users
  module Passwords
    class UpdateOperation < ApplicationOperation
      option :params
      option :contract, default: proc { Users::Passwords::UpdateContract.new }

      def call
        contract_params = yield validate(contract)
        result = yield call_service(contract_params)

        Success(result)
      end

      private

      def call_service(contract_params)
        Users::Passwords::UpdateService.new(params: contract_params).call
      end
    end
  end
end
