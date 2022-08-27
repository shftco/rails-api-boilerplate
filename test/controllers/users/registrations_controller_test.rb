# frozen_string_literal: true

require 'test_helper'

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test 'should register and then generate access token' do
    doorkeeper_application = create(:doorkeeper_application)
    params = attributes_for(:user)
    params[:client_id] = doorkeeper_application.uid

    assert_difference(['Doorkeeper::AccessToken.count', 'User.count'], 1) do
      post(user_registration_url, params:, as: :json)
    end

    assert_equal params[:email], load_body(response)[:user][:email]
    assert_response :created
  end

  test 'should not register with invalid params' do
    old_user = create(:user)
    doorkeeper_application = create(:doorkeeper_application)

    invalid_user_params = attributes_for(:user, email: old_user.email)
    invalid_user_params[:client_id] = doorkeeper_application.uid

    assert_no_difference(['Doorkeeper::AccessToken.count', 'User.count'], 1) do
      post(user_registration_url, params: invalid_user_params, as: :json)
    end

    assert_equal 1, errors_count(response)
    assert error_message?(response, 'Email has already been taken')
    assert_response :unprocessable_entity
  end

  test 'should not register with invalid client' do
    user_params = attributes_for(:user)

    assert_no_difference(['Doorkeeper::AccessToken.count', 'User.count'], 1) do
      post(user_registration_url, params: user_params, as: :json)
    end

    assert error_message?(response, I18n.t('doorkeeper.errors.messages.invalid_client'))
    assert_equal 1, errors_count(response)
    assert_response :bad_request
  end
end
