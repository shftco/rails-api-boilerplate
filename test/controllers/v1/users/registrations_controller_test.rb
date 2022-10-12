# frozen_string_literal: true

require 'test_helper'

module V1
  module Users
    class RegistrationsControllerTest < ActionDispatch::IntegrationTest
      attr_reader :doorkeeper_application

      def setup
        @doorkeeper_application = create(:doorkeeper_application)
      end

      test 'create#should register and then generate access token' do
        params = { email: 'tester@mail.com',
                   password: '123456',
                   client_id: doorkeeper_application.uid,
                   client_secret: doorkeeper_application.secret }

        assert_difference(['Doorkeeper::AccessToken.count', 'User.count'], 1) do
          post(v1_users_registration_url, params:, as: :json)
        end

        body = load_body(response)

        assert_equal params[:email], body.user.email
        assert_response :created
      end

      test 'create#should not register if email has already been taken' do
        old_user = create(:user)
        params = { email: old_user.email,
                   password: '123456',
                   client_id: doorkeeper_application.uid,
                   client_secret: doorkeeper_application.secret }

        assert_no_difference(['Doorkeeper::AccessToken.count', 'User.count'], 1) do
          post(v1_users_registration_url, params:, as: :json)
        end

        assert_equal 1, errors_count(response)
        assert error_message?(response, 'Email has already been taken')
        assert_response :unprocessable_entity
      end

      test 'create#should return errors if oauth client id is invalid' do
        params = { email: 'tester@mail.com',
                   password: '123456',
                   client_id: 'invalid',
                   client_secret: doorkeeper_application.secret }

        assert_no_difference(['Doorkeeper::AccessToken.count', 'User.count'], 1) do
          post(v1_users_registration_url, params:, as: :json)
        end

        assert error_message?(response, I18n.t('doorkeeper.errors.messages.invalid_client'))
        assert_equal 1, errors_count(response)
        assert_response :unauthorized
      end

      test 'create#should return errors if oauth client secret is invalid' do
        params = { email: 'tester@mail.com',
                   password: '123456',
                   client_id: doorkeeper_application.uid,
                   client_secret: 'invalid' }

        assert_no_difference(['Doorkeeper::AccessToken.count', 'User.count'], 1) do
          post(v1_users_registration_url, params:, as: :json)
        end

        assert error_message?(response, I18n.t('doorkeeper.errors.messages.invalid_client'))
        assert_equal 1, errors_count(response)
        assert_response :unauthorized
      end
    end
  end
end
