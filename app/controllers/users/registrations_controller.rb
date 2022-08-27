# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :check_client, only: %i[create]

  include DoorkeeperRegisterable

  def create
    operation = Users::Registrations::CreateOperation.new(params: registration_params).call

    if operation.success?
      render json: render_user(operation.success, @client_app), status: :created
    else
      render json: operation.failure, status: :unprocessable_entity
    end
  end

  private

  def check_client
    @client_app = Doorkeeper::Application.find_by(uid: registration_params[:client_id])

    return if @client_app

    render json: { errors: [I18n.t('doorkeeper.errors.messages.invalid_client')] }, status: :bad_request
  end

  def registration_params
    params.permit(:email, :password, :client_id)
  end
end
