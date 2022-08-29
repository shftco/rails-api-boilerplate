# frozen_string_literal: true

require 'test_helper'

module Users
  class TokensControllerTest < ActionDispatch::IntegrationTest
    attr_reader :user, :application, :token

    def setup
      @user = create(:user)
      @application = create(:doorkeeper_application)
      @token = create(:doorkeeper_access_token, application: @application, resource_owner: @user)
    end

    test 'should generate new access and refresh tokens' do
      assert_difference('Doorkeeper::AccessToken.count') do
        post(oauth_token_url,
             params: oauth_token_params(user, application),
             as: :json)
      end

      body = load_body(response)

      assert body.key?(:access_token)
      assert body.key?(:refresh_token)
      assert body.key?(:token_type)
      assert body.key?(:expires_in)
      assert body.key?(:created_at)
      assert_response :success
    end

    test 'should not generate new access and refresh tokens if user credentials is invalid' do
      invalid_user = build(:user)

      assert_no_difference('Doorkeeper::AccessToken.count') do
        post(oauth_token_url,
             params: oauth_token_params(invalid_user, application),
             as: :json)
      end

      body = load_body(response)

      assert body.key?(:error)
      assert_equal 'invalid_grant', body[:error]
      assert_response :bad_request
    end

    test 'should revoke access token' do
      assert_changes -> { token.revoked_at } do
        post(oauth_revoke_url,
             params: oauth_revoke_params(token),
             as: :json)

        token.reload
      end

      assert_response :success
    end

    test 'should not revoke access token if token has already revoked' do
      token.revoke

      assert_no_changes -> { token.revoked_at } do
        post(oauth_revoke_url,
             params: oauth_revoke_params(token),
             as: :json)

        token.reload
      end

      assert_response :success
    end

    test 'should generate new access and refresh tokens with refresh token' do
      assert_difference('Doorkeeper::AccessToken.count') do
        post(oauth_token_url,
             params: oauth_refresh_token_params(token),
             as: :json)
      end

      body = load_body(response)

      assert body.key?(:access_token)
      assert body.key?(:refresh_token)
      assert body.key?(:token_type)
      assert body.key?(:expires_in)
      assert body.key?(:created_at)
      assert_response :success
    end

    test 'should not generate new access and refresh tokens if refresh token is invalid' do
      assert_no_difference('Doorkeeper::AccessToken.count') do
        post(oauth_token_url,
             params: oauth_refresh_token_params(token, 'token'))
      end

      body = load_body(response)

      assert body.key?(:error)
      assert_equal 'invalid_grant', body[:error]
      assert_response :bad_request
    end
  end
end
