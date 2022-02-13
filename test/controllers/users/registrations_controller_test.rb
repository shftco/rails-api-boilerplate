# frozen_string_literal: true

require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test 'should register and then generate access token' do
    @user_params = attributes_for(:user).merge(
      client_id: create(:doorkeeper_application).uid
    )

    assert_difference(['Doorkeeper::AccessToken.count', 'User.count'], 1) do
      post(user_registration_url,
           params: @user_params,
           as: :json)
    end

    assert_equal @user_params[:email], load_body(response)[:user][:email]
    assert_response :created
  end

  test 'should not register with invalid params' do
    invalid_user_params = attributes_for(
      :user,
      email: create(:user).email
    ).merge(client_id: create(:doorkeeper_application).uid)

    assert_no_difference(['Doorkeeper::AccessToken.count', 'User.count'], 1) do
      post(user_registration_url,
           params: invalid_user_params,
           as: :json)
    end

    assert error?(response, :email)
    assert error_message?(response, :email, 'has already been taken')
    assert_equal 1, error_count(response)
    assert_response :unprocessable_entity
  end

  test 'should not register with invalid client' do
    user_params = attributes_for(:user)

    assert_no_difference(['Doorkeeper::AccessToken.count', 'User.count'], 1) do
      post(user_registration_url,
           params: user_params,
           as: :json)
    end

    assert error?(response, :client)
    assert error_message?(response, :client, I18n.t('doorkeeper.errors.messages.invalid_client'))
    assert_equal 1, error_count(response)
    assert_response :bad_request
  end
end
