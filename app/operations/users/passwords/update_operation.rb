# frozen_string_literal: true

module Users
  module Passwords
    class UpdateOperation < ApplicationOperation
      include Dry::Monads[:result]
      include Dry::Monads::Do.for(:call)

      option :params
      option :contract, default: proc { Users::Passwords::UpdateContract.new }

      def call
        contract_params = yield validate(contract)
        result = yield update_password(contract_params)

        Success(result)
      end

      private

      def update_password(contract_params)
        UsersService::Passwords::Update.new(params: contract_params).call
      end
    end
  end
end
