# frozen_string_literal: true

require 'test_helper'

class UsersService::Registrations::RegisterTest < ActiveSupport::TestCase
  attr_reader :params

  def setup
    @params = attributes_for(:user)
  end

  test 'should register user' do
    assert_difference('User.count', 1) do
      service = UsersService::Registrations::Register.new(params:).call

      user = service.success

      assert service.success?
      assert_equal params[:email], user.email
      assert_equal params[:password], user.password
    end
  end

  test 'should fail if user service returns failure' do
    user_service = mock
    UsersService::Create.expects(:new).returns(user_service)
    user_service.expects(:call).returns(Dry::Monads::Result::Failure.new(:failed_because_of_me))

    assert_no_difference('User.count') do
      service = UsersService::Registrations::Register.new(params:).call

      assert service.failure?
      assert_equal :failed_because_of_me, service.failure
    end
  end
end
