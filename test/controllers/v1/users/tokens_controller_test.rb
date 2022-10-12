# frozen_string_literal: true

require 'test_helper'

module V1
  module Users
    class TokensControllerTest < ActionDispatch::IntegrationTest
      attr_reader :user, :doorkeeper_application, :token

      def setup
        @user = create(:user)
        @doorkeeper_application = create(:doorkeeper_application)
        @token = create(:doorkeeper_access_token, application: @doorkeeper_application, resource_owner: @user)
      end

      test 'create#should generate new access and refresh tokens' do
        assert_difference('Doorkeeper::AccessToken.count') do
          post(v1_users_oauth_token_url,
               params: oauth_token_params(user, doorkeeper_application),
               as: :json)
        end

        body = load_body(response)

        assert_respond_to body, :access_token
        assert_respond_to body, :refresh_token
        assert_respond_to body, :token_type
        assert_respond_to body, :expires_in
        assert_respond_to body, :created_at
        assert_respond_to body.user, :email
        assert_respond_to body.user, :type
        assert_respond_to body.user, :id
        assert_response :success
      end

      test 'create#should fail client id is invalid' do
        params = { grant_type: 'password',
                   email: user.email,
                   password: user.password,
                   client_id: 'invalid',
                   client_secret: doorkeeper_application.secret }

        assert_no_difference('Doorkeeper::AccessToken.count') do
          post(v1_users_oauth_token_url, params:, as: :json)
        end

        assert error_message?(response, I18n.t('doorkeeper.errors.messages.invalid_client'))
        assert_equal 1, errors_count(response)
        assert_response :unauthorized
      end

      test 'create#should fail client secret is invalid' do
        params = { grant_type: 'password',
                   email: user.email,
                   password: user.password,
                   client_id: doorkeeper_application.uid,
                   client_secret: 'invalid' }

        assert_no_difference('Doorkeeper::AccessToken.count') do
          post(v1_users_oauth_token_url, params:, as: :json)
        end

        assert error_message?(response, I18n.t('doorkeeper.errors.messages.invalid_client'))
        assert_equal 1, errors_count(response)
        assert_response :unauthorized
      end

      test 'create#should not generate new access and refresh tokens if user credentials is invalid' do
        invalid_user = build(:user)

        assert_no_difference('Doorkeeper::AccessToken.count') do
          post(v1_users_oauth_token_url,
               params: oauth_token_params(invalid_user, doorkeeper_application),
               as: :json)
        end

        assert error_message?(response, I18n.t('devise.failure.invalid', authentication_keys: User.authentication_keys.join('/')))
        assert_equal 1, errors_count(response)
        assert_response :bad_request
      end

      test 'create#should generate new access and refresh tokens with refresh token' do
        assert_difference('Doorkeeper::AccessToken.count') do
          post(v1_users_oauth_token_url,
               params: oauth_refresh_token_params(token),
               as: :json)
        end

        body = load_body(response)

        assert_respond_to body, :access_token
        assert_respond_to body, :refresh_token
        assert_respond_to body, :token_type
        assert_respond_to body, :expires_in
        assert_respond_to body, :created_at
        assert_response :success
      end

      test 'create#should not generate new access and refresh tokens if refresh token is invalid' do
        assert_no_difference('Doorkeeper::AccessToken.count') do
          post(v1_users_oauth_token_url,
               params: oauth_refresh_token_params(token, 'token'))
        end

        assert error_message?(response, I18n.t('devise.failure.invalid', authentication_keys: User.authentication_keys.join('/')))
        assert_equal 1, errors_count(response)
        assert_response :bad_request
      end

      test 'revoke#should revoke access token' do
        assert_changes -> { token.revoked_at } do
          post(v1_users_oauth_revoke_url,
               params: oauth_revoke_params(token),
               as: :json)

          token.reload
        end

        assert_response :success
      end

      test 'revoke#should not revoke access token if token has already revoked' do
        token.revoke

        assert_no_changes -> { token.revoked_at } do
          post(v1_users_oauth_revoke_url, params: oauth_revoke_params(token), as: :json)

          token.reload
        end

        assert_response :success
      end

      test 'revoke#should fail client id is invalid' do
        params = { token: token.token,
                   client_id: 'invalid',
                   client_secret: doorkeeper_application.secret }

        assert_no_changes -> { token.revoked_at } do
          post(v1_users_oauth_revoke_url, params:, as: :json)

          token.reload
        end

        assert error_message?(response, I18n.t('doorkeeper.errors.messages.revoke.unauthorized'))
        assert_equal 1, errors_count(response)
        assert_response :forbidden
      end

      test 'revoke#should fail client secret is invalid' do
        params = { token: token.token,
                   client_id: doorkeeper_application.uid,
                   client_secret: 'invalid' }

        assert_no_changes -> { token.revoked_at } do
          post(v1_users_oauth_revoke_url, params:, as: :json)

          token.reload
        end

        assert error_message?(response, I18n.t('doorkeeper.errors.messages.revoke.unauthorized'))
        assert_equal 1, errors_count(response)
        assert_response :forbidden
      end
    end
  end
end
