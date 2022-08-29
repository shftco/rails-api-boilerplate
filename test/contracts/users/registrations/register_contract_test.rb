# frozen_string_literal: true

require 'test_helper'

module Users
  module Registrations
    class RegisterContractTest < ActiveSupport::TestCase
      CONTRACT = Users::Registrations::RegisterContract.new

      def validate(payload: {})
        CONTRACT.call(payload)
      end

      test 'validate#email' do
        success?(validate(payload: { email: 'test@test.com' }), :email, CONTRACT)
        filled?(validate(payload: { email: nil }), :email, CONTRACT)
        filled?(validate(payload: { email: '' }), :email, CONTRACT)
        invalid?(validate(payload: { email: 'invalid email' }), :email, CONTRACT)
      end

      test 'validate#password' do
        success?(validate(payload: { password: '123456' }), :password, CONTRACT)
        filled?(validate(payload: { password: nil }), :password, CONTRACT)
        filled?(validate(payload: { password: '' }), :password, CONTRACT)
        min_size?(validate(payload: { password: '12345' }), :password, 6, CONTRACT)
      end
    end
  end
end
