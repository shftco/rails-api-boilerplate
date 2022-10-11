# frozen_string_literal: true

require 'test_helper'

module Users
  module Passwords
    class UpdateContractTest < ActiveSupport::TestCase
      CONTRACT = Users::Passwords::UpdateContract.new

      def validate(payload = {})
        CONTRACT.call(payload)
      end

      test 'validate#reset_password_token' do
        success?(validate({ reset_password_token: 'token' }), :reset_password_token, CONTRACT)
        filled?(validate({ reset_password_token: nil }), :reset_password_token, CONTRACT)
        filled?(validate({ reset_password_token: '' }), :reset_password_token, CONTRACT)
        str?(validate({ reset_password_token: 1 }), :reset_password_token, CONTRACT)
      end

      test 'validate#password' do
        success?(validate({ password: '123456', password_confirmation: '123456' }), :password, CONTRACT)
        filled?(validate({ password: nil }), :password, CONTRACT)
        filled?(validate({ password: '' }), :password, CONTRACT)
        min_size?(validate({ password: '12345' }), :password, 6, CONTRACT)
        same_password?(validate({ password: '1234566', password_confirmation: '123456' }), :password, CONTRACT)
      end

      test 'validate#password_confirmation' do
        success?(validate({ password_confirmation: '123456', password: '123456' }), :password_confirmation, CONTRACT)
        filled?(validate({ password_confirmation: nil }), :password_confirmation, CONTRACT)
        filled?(validate({ password_confirmation: '' }), :password_confirmation, CONTRACT)
        min_size?(validate({ password_confirmation: '12345' }), :password_confirmation, 6, CONTRACT)
        same_password?(validate({ password_confirmation: '1234566', password: '123456' }), :password_confirmation, CONTRACT)
      end
    end
  end
end
