# frozen_string_literal: true

require 'test_helper'

module Users
  module Passwords
    class CreateOperationTest < ActiveSupport::TestCase
      test 'should pass contract validation then calling the service' do
        params_mock = mock
        params_mock.expects(:to_h).returns(params_mock)

        contract_mock = mock
        Users::Passwords::SendInstructionsContract.expects(:new).returns(contract_mock)
        contract_mock.expects(:call).with(params_mock).returns(contract_mock)
        contract_mock.expects(:success?).returns(true)
        contract_mock.expects(:to_h).returns(contract_mock)

        service_mock = mock
        Users::Passwords::SendInstructionsService.expects(:new).returns(service_mock)
        service_mock.expects(:call).returns(Dry::Monads::Result::Success.new(true))

        operation = Users::Passwords::CreateOperation.new(params: params_mock).call

        assert operation.success?
      end

      test 'should return errors if something goes wrong while validating params' do
        service_mock = mock
        Users::Passwords::SendInstructionsService.expects(:new).returns(service_mock).never

        operation = Users::Passwords::CreateOperation.new(params: {}).call

        errors = contract_errors_parser(operation.failure)

        assert operation.failure?
        assert_equal errors[:email], 'is missing'
      end

      test 'should return errors if something goes wrong while executing service' do
        params_mock = mock
        params_mock.expects(:to_h).returns(params_mock)

        contract_mock = mock
        Users::Passwords::SendInstructionsContract.expects(:new).returns(contract_mock)
        contract_mock.expects(:call).with(params_mock).returns(contract_mock)
        contract_mock.expects(:success?).returns(true)
        contract_mock.expects(:to_h).returns(contract_mock)

        service_mock = mock
        Users::Passwords::SendInstructionsService.expects(:new).returns(service_mock)
        service_mock.expects(:call).returns(Dry::Monads::Result::Failure.new(:failed_because_of_me))

        operation = Users::Passwords::CreateOperation.new(params: params_mock).call

        assert operation.failure?
        assert_equal :failed_because_of_me, operation.failure
      end
    end
  end
end
