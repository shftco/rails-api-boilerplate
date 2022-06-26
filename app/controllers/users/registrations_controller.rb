# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :check_client, only: %i[create]

  include DoorkeeperRegisterable

  def create
    @form = UserForm::Registration.new(User.new)

    unless @form.validate(registration_params.except(:client_id))
      return render json: to_json_form_errors(@form),
                    status: :unauthorized
    end

    @form.save do |form_params|
      service = RegistrationService::Register.new(params: form_params.deep_symbolize_keys).call

      return render json: render_user(service.success, @client_app), status: :created if service.success?

      render json: { errors: service.failure[1] }, status: :unprocessable_entity
    end
  end

  private

  def check_client
    @client_app = Doorkeeper::Application.find_by(uid: registration_params[:client_id])

    return if @client_app

    render json: { errors: { client: [I18n.t('doorkeeper.errors.messages.invalid_client')] } },
           status: :bad_request
  end

  def registration_params
    params.permit(:email, :password, :client_id)
  end
end
