# frozen_string_literal: true

require 'test_helper'

class RegistrationService::RegisterTest < ActiveSupport::TestCase
  def setup
    @params = attributes_for(:user)
  end

  test 'should register user' do
    assert_difference('User.count', 1) do
      service = RegistrationService::Register.new(params: @params).call

      user = service.success

      assert service.success?
      assert_equal @params[:email], user.email
      assert_equal @params[:password], user.password
    end
  end

  test 'should fail if user service returns failure' do
    branch_user_service = mock
    UserService::Create.expects(:new).returns(branch_user_service)
    branch_user_service.expects(:call).returns(Dry::Monads::Result::Failure.new(:failed_because_of_me))

    assert_no_difference('User.count') do
      service = RegistrationService::Register.new(params: @params).call

      assert service.failure?
      assert_equal :failed_because_of_me, service.failure
    end
  end
end
