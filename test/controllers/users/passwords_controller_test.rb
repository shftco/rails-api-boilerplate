# frozen_string_literal: true

require 'test_helper'

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  test 'should send an email and returns a information message' do
    user = create(:user)
    params = { email: user.email }

    assert_difference('Devise.mailer.deliveries.count') do
      post(user_password_url, params:, as: :json)
    end

    body = load_body(response)

    assert_equal I18n.t('.devise.passwords.send_instructions'), body[:message]
    assert_response :ok
  end

  test 'should not send an email and returns errors with invalid email' do
    builded_user = build(:user)
    params = { email: builded_user.email }

    assert_no_difference('Devise.mailer.deliveries.count') do
      post(user_password_url, params:, as: :json)
    end

    error_message?(response, 'Email not found')
    assert_equal 1, errors_count(response)
    assert_response :unprocessable_entity
  end

  test 'should update password with valid params' do
    user = create(:user, updated_at: 1.day.ago)
    token = user.send_reset_password_instructions
    params = { reset_password_token: token, password: user.password, password_confirmation: user.password }

    assert_changes -> { user.updated_at } do
      patch(user_password_url, params:, as: :json)

      user.reload
    end

    body = load_body(response)

    assert_equal I18n.t('.devise.passwords.updated_not_active'), body[:message]
    assert_response :ok
  end

  test 'should not update password with invalid token' do
    user = create(:user)
    user.send_reset_password_instructions
    params = { reset_password_token: Faker::Lorem.characters(number: 10), password: user.password, password_confirmation: user.password }

    assert_no_changes -> { user.updated_at } do
      patch(user_password_url, params:, as: :json)

      user.reload
    end

    assert error_message?(response, 'Reset password token is invalid')
    assert_equal 1, errors_count(response)
    assert_response :unprocessable_entity
  end
end
