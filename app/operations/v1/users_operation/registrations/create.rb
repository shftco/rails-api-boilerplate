# frozen_string_literal: true

module V1
  module UsersOperation
    module Registrations
      class Create < ApplicationOperation
        option :params
        option :doorkeeper_application, type: Types.Instance(Doorkeeper::Application)
        option :contract, default: proc { V1::UsersContract::Registrations::Register.new }

        def call
          contract_params = yield validate(contract)
          user = yield call_service(contract_params)

          Success(user)
        end

        private

        def call_service(contract_params)
          UsersService::Registrations::Register.new(params: contract_params, doorkeeper_application:).call
        end
      end
    end
  end
end
