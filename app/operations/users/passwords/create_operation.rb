# frozen_string_literal: true

module Users
  module Passwords
    class CreateOperation < ApplicationOperation
      option :params
      option :contract, default: proc { Users::Passwords::SendInstructionsContract.new }

      def call
        contract_params = yield validate(contract)
        result = yield send_instructions(contract_params)

        Success(result)
      end

      private

      def send_instructions(contract_params)
        Users::Passwords::SendInstructionsService.new(params: contract_params).call
      end
    end
  end
end
