# frozen_string_literal: true

module V1
  module Users
    class PasswordsController < ApplicationController
      include Doorkeeper::Authorize

      def create
        operation = ::Users::Passwords::CreateOperation.new(params: password_params).call

        if operation.success?
          render json: operation.success, status: :ok
        else
          render json: operation.failure, status: :unprocessable_entity
        end
      end

      def update
        operation = ::Users::Passwords::UpdateOperation.new(params: password_params).call

        if operation.success?
          render json: operation.success, status: :ok
        else
          render json: operation.failure, status: :unprocessable_entity
        end
      end

      private

      def password_params
        params.permit(:email, :reset_password_token, :password, :password_confirmation)
      end
    end
  end
end
