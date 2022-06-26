# frozen_string_literal: true

module Users
  class PasswordsController < Devise::PasswordsController
    def create
      self.resource = resource_class.send_reset_password_instructions(password_params)
      yield resource if block_given?

      return render json: { message: I18n.t('devise.passwords.send_instructions') }, status: :ok if successfully_sent?(resource)

      render json: { errors: resource.errors }, status: :unprocessable_entity
    end

    def update
      self.resource = resource_class.reset_password_by_token(password_params)
      yield resource if block_given?

      return render json: { message: I18n.t('devise.passwords.updated_not_active') }, status: :ok if resource.errors.empty?

      render json: { errors: resource.errors }, status: :unprocessable_entity
    end

    private

    def password_params
      params.permit(:email, :reset_password_token, :password, :password_confirmation)
    end
  end
end
