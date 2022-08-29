# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  include Doorkeeper::Authorize
  include Doorkeeper::Registerable

  def create
    operation = Users::Registrations::CreateOperation.new(params: registration_params).call

    if operation.success?
      render json: render_user(operation.success, current_doorkeeper_application), status: :created
    else
      render json: operation.failure, status: :unprocessable_entity
    end
  end

  private

  def registration_params
    params.permit(:email, :password)
  end
end
