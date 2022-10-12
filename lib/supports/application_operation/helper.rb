# frozen_string_literal: true

module Supports
  module ApplicationOperation
    module Helper
      def validate(contract)
        result = contract.call(params.to_h)

        return contract_success(result) if result.success?

        contract_failure(result, contract)
      end

      def contract_failure(result, contract)
        Failure(contract_error_parser(result, contract))
      end

      def contract_success(result)
        Success(result.to_h)
      end
    end
  end
end
