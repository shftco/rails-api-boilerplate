# frozen_string_literal: true

require "test_helper"

class UserForm::RegistrationTest < ActiveSupport::TestCase
  def validate(user: User.new, payload: {})
    form = UserForm::Registration.new(user)
    form.validate(payload)
    form
  end

  test 'validate#email' do
    success?(validate(payload: { email: 'test@test.com' }), :email)
    filled?(validate(payload: { email: nil }), :email)
    filled?(validate(payload: { email: '' }), :email)
    invalid?(validate(payload: { email: 'invalid email' }), :email)
  end

  test 'validate#password' do
    success?(validate(payload: { password: '123456' }), :password)
    filled?(validate(payload: { password: nil }), :password)
    filled?(validate(payload: { password: '' }), :password)
    min_size?(validate(payload: { password: '12345' }), :password, 6)
  end
end
