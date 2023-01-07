# frozen_string_literal: true

module V1
  module UsersOperation
    module Passwords
      class Update < ApplicationOperation
        option :params
        option :contract, default: proc { V1::UsersContract::Passwords::Update.new }

        def call
          contract_params = yield validate(contract)
          result = yield call_service(contract_params)

          Success(result)
        end

        private

        def call_service(contract_params)
          UsersService::Passwords::Update.new(params: contract_params).call
        end
      end
    end
  end
end
