# frozen_string_literal: true

require 'test_helper'

module V1
  module UsersContract
    module Registrations
      class RegisterTest < ActiveSupport::TestCase
        CONTRACT = V1::UsersContract::Registrations::Register.new

        def validate(payload = {})
          CONTRACT.call(payload)
        end

        test 'validate#email' do
          success?(validate({ email: 'test@test.com' }), :email, CONTRACT)
          filled?(validate({ email: nil }), :email, CONTRACT)
          filled?(validate({ email: '' }), :email, CONTRACT)
          format?(validate({ email: 'invalid email' }), :email, CONTRACT)
        end

        test 'validate#password' do
          success?(validate({ password: '123456' }), :password, CONTRACT)
          filled?(validate({ password: nil }), :password, CONTRACT)
          filled?(validate({ password: '' }), :password, CONTRACT)
          min_size?(validate({ password: '12345' }), :password, 6, CONTRACT)
        end
      end
    end
  end
end
