# frozen_string_literal: true

module V1
  module Users
    class RegistrationsController < ApplicationController
      include Doorkeeper::Authorize

      def create
        operation = V1::UsersOperation::Registrations::Create.new(params: registration_params,
                                                                  doorkeeper_application: current_doorkeeper_application).call

        if operation.success?
          render json: Models::Doorkeeper::AccessTokenBlueprint.render(operation.success,
                                                                       view: :with_resource_owner_and_application),
                 status: :created
        else
          render json: operation.failure, status: :unprocessable_entity
        end
      end

      private

      def registration_params
        params.permit(:email, :password)
      end
    end
  end
end
