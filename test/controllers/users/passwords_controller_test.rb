# frozen_string_literal: true

require 'test_helper'

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  test 'should send an email and returns a information message' do
    assert_difference('Devise.mailer.deliveries.count') do
      post(user_password_url,
           params: {
             email: create(:user).email
           },
           as: :json)
    end

    assert_equal I18n.t('.devise.passwords.send_instructions'), load_body(response)[:message]
    assert_response :ok
  end

  test 'should not send an email and returns errors with invalid email' do
    assert_no_difference('Devise.mailer.deliveries.count') do
      post(user_password_url,
           params: {
             email: build(:user).email
           },
           as: :json)
    end

    assert error?(response, :email)
    assert error_message?(response, :email, 'not found')
    assert_equal 1, error_count(response)
    assert_response :unprocessable_entity
  end

  test 'should update password with valid params' do
    user = create(:user, updated_at: 1.day.ago)
    token = user.send_reset_password_instructions

    assert_changes -> { user.updated_at } do
      patch(user_password_url,
            params: {
              reset_password_token: token,
              password: user.password,
              password_confirmation: user.password
            },
            as: :json)

      user.reload
    end

    assert_equal I18n.t('.devise.passwords.updated_not_active'), load_body(response)[:message]
    assert_response :ok
  end

  test 'should not update password with invalid token' do
    user = create(:user)
    user.send_reset_password_instructions

    assert_no_changes -> { user.updated_at } do
      patch(user_password_url,
            params: {
              reset_password_token: Faker::Lorem.characters(number: 10),
              password: user.password,
              password_confirmation: user.password
            },
            as: :json)

      user.reload
    end

    assert error?(response, :reset_password_token)
    assert error_message?(response, :reset_password_token, 'is invalid')
    assert_equal 1, error_count(response)
    assert_response :unprocessable_entity
  end
end
