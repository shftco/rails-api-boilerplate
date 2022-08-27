# frozen_string_literal: true

require 'dry/monads/all'
require 'dry-initializer'

class ApplicationOperation
  extend Dry::Initializer

  include ContractErrorParser

  def validate(form)
    result = form.call(params.as_json)

    return form_success(result) if result.success?

    form_failure(result, form)
  end

  private

  def form_failure(result, form)
    Failure(contract_errors_handler(result, form))
  end

  def form_success(result)
    Success(result.to_h)
  end
end
