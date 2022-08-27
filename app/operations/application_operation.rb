# frozen_string_literal: true

require 'dry/monads/all'
require 'dry-initializer'

class ApplicationOperation
  extend Dry::Initializer

  include ContractErrorParser

  def validate(contract)
    result = contract.call(params.as_json)

    return contract_success(result) if result.success?

    contract_failure(result, contract)
  end

  private

  def contract_failure(result, contract)
    Failure(contract_errors_handler(result, contract))
  end

  def contract_success(result)
    Success(result.to_h)
  end
end
