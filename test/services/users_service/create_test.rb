# frozen_string_literal: true

require 'test_helper'

class UsersService::CreateTest < ActiveSupport::TestCase
  def setup
    @user_params = attributes_for(:user)
  end

  test 'should create user' do
    assert_difference 'User.count', 1 do
      service = UsersService::Create.new(params: @user_params).call
      assert service.success?
    end
  end

  test 'should fail if something goes wrong' do
    User.any_instance.expects(:save).returns(false)

    assert_no_difference 'User.count' do
      service = UsersService::Create.new(params: @user_params).call
      assert service.failure?
    end
  end
end
