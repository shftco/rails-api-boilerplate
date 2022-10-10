# frozen_string_literal: true

require 'test_helper'

module Users
  module Registrations
    class RegisterServiceTest < ActiveSupport::TestCase
      attr_reader :params, :doorkeeper_application

      def setup
        @params = attributes_for(:user)
        @doorkeeper_application = create(:doorkeeper_application)
      end

      test 'should register user' do
        assert_difference(['User.count', 'Doorkeeper::AccessToken.count'], 1) do
          service = Users::Registrations::RegisterService.new(params:, doorkeeper_application:).call

          user = service.success[:user]

          assert service.success?
          assert_equal params[:email], user[:email]
        end
      end

      test 'should return error if something goes wrong while creating doorkeeper access token' do
        access_token_service_mock = mock
        Doorkeeper::AccessTokens::CreateService.expects(:new).returns(access_token_service_mock)
        access_token_service_mock.expects(:call).returns(Dry::Monads::Result::Failure.new(:failed_because_of_me))

        assert_no_difference(['User.count', 'Doorkeeper::AccessToken.count']) do
          service = Users::Registrations::RegisterService.new(params:, doorkeeper_application:).call

          assert service.failure?
          assert_equal :failed_because_of_me, service.failure
        end
      end

      test 'should fail if user service returns failure' do
        user_service = mock
        Users::CreateService.expects(:new).returns(user_service)
        user_service.expects(:call).returns(Dry::Monads::Result::Failure.new(:failed_because_of_me))

        assert_no_difference(['User.count', 'Doorkeeper::AccessToken.count']) do
          service = Users::Registrations::RegisterService.new(params:, doorkeeper_application:).call

          assert service.failure?
          assert_equal :failed_because_of_me, service.failure
        end
      end
    end
  end
end
