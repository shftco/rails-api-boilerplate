# frozen_string_literal: true

module Users
  module Registrations
    class CreateOperation < ApplicationOperation
      include Dry::Monads[:result]
      include Dry::Monads::Do.for(:call)

      option :params
      option :form, default: proc { Users::RegistrationContract.new }

      def call
        form_params = yield validate(form)
        user = yield register_user(form_params)

        Success(user)
      end

      private

      def register_user(form_params)
        UsersService::Registration::Register.new(params: form_params).call
      end
    end
  end
end
