# frozen_string_literal: true

require 'test_helper'

module V1
  module Users
    class PasswordsControllerTest < ActionDispatch::IntegrationTest
      attr_reader :doorkeeper_application, :user

      def setup
        @doorkeeper_application = create(:doorkeeper_application)
        @user = create(:user)
      end

      test 'create#should send an email then returns an information message' do
        params = { email: user.email,
                   client_id: doorkeeper_application.uid,
                   client_secret: doorkeeper_application.secret }

        assert_difference('Devise.mailer.deliveries.count') do
          post(v1_users_password_url, params:, as: :json)
        end

        body = load_body(response)

        assert_equal I18n.t('devise.passwords.send_instructions'), body.message
        assert_response :ok
      end

      test 'create#should return errors if oauth client id is invalid' do
        params = { email: user.email,
                   client_id: 'invalid',
                   client_secret: doorkeeper_application.secret }

        assert_no_difference('Devise.mailer.deliveries.count') do
          post(v1_users_password_url, params:, as: :json)
        end

        assert_equal 1, errors_count(response)
        error_message?(response, I18n.t('doorkeeper.errors.messages.invalid_client'))
        assert_response :unauthorized
      end

      test 'create#should return errors if oauth client secret is invalid' do
        params = {  email: user.email,
                    client_id: doorkeeper_application.uid,
                    client_secret: 'invalid' }

        assert_no_difference('Devise.mailer.deliveries.count') do
          post(v1_users_password_url, params:, as: :json)
        end

        assert_equal 1, errors_count(response)
        error_message?(response, I18n.t('doorkeeper.errors.messages.invalid_client'))
        assert_response :unauthorized
      end

      test 'create#should not send an email then returns errors if email was not found' do
        params = { email: 'not@registered.com',
                   client_id: doorkeeper_application.uid,
                   client_secret: doorkeeper_application.secret }

        assert_no_difference('Devise.mailer.deliveries.count') do
          post(v1_users_password_url, params:, as: :json)
        end

        error_message?(response, 'Email not found')
        assert_equal 1, errors_count(response)
        assert_response :unprocessable_entity
      end

      test 'update#should update password' do
        token = user.send_reset_password_instructions
        params = { reset_password_token: token,
                   password: user.password,
                   password_confirmation: user.password,
                   client_id: doorkeeper_application.uid,
                   client_secret: doorkeeper_application.secret }

        assert_changes -> { user.updated_at } do
          patch(v1_users_password_url, params:, as: :json)

          user.reload
        end

        body = load_body(response)

        assert_equal I18n.t('devise.passwords.updated_not_active'), body.message
        assert_response :ok
      end

      test 'update#should return errors if oauth client id is invalid' do
        token = user.send_reset_password_instructions
        params = { reset_password_token: token,
                   password: user.password,
                   password_confirmation: user.password,
                   client_id: 'invalid',
                   client_secret: doorkeeper_application.secret }

        assert_no_difference('Devise.mailer.deliveries.count') do
          patch(v1_users_password_url, params:, as: :json)
        end

        assert_equal 1, errors_count(response)
        error_message?(response, I18n.t('doorkeeper.errors.messages.invalid_client'))
        assert_response :unauthorized
      end

      test 'update#should return errors if oauth client secret is invalid' do
        token = user.send_reset_password_instructions
        params = { reset_password_token: token,
                   password: user.password,
                   password_confirmation: user.password,
                   client_id: doorkeeper_application.uid,
                   client_secret: 'invalid' }

        assert_no_difference('Devise.mailer.deliveries.count') do
          patch(v1_users_password_url, params:, as: :json)
        end

        assert_equal 1, errors_count(response)
        error_message?(response, I18n.t('doorkeeper.errors.messages.invalid_client'))
        assert_response :unauthorized
      end

      test 'update#should not update password with invalid token' do
        user.send_reset_password_instructions
        params = { reset_password_token: 'so_secret_token',
                   password: user.password,
                   password_confirmation: user.password,
                   client_id: doorkeeper_application.uid,
                   client_secret: doorkeeper_application.secret }

        assert_no_changes -> { user.updated_at } do
          patch(v1_users_password_url, params:, as: :json)

          user.reload
        end

        assert error_message?(response, 'Reset password token is invalid')
        assert_equal 1, errors_count(response)
        assert_response :unprocessable_entity
      end
    end
  end
end
