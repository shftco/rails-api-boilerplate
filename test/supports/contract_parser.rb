# frozen_string_literal: true

module Supports
  module ContractParser
    def contract_errors_parser(contract_result)
      errors = {}

      contract_result.fetch(:errors, []).each do |err|
        k = err.keys.first
        v = err.values.first
        errors[k] = v
      end

      errors
    end
  end
end
