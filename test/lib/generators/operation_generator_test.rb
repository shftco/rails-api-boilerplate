# frozen_string_literal: true

require 'test_helper'
require 'generators/operation/operation_generator'

class OperationGeneratorTest < Rails::Generators::TestCase
  tests OperationGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  test 'generator runs without errors' do
    assert_nothing_raised do
      run_generator ['Seller']
    end
  end

  test 'generator creates operation files' do
    run_generator ['Seller::Create']

    assert_file 'app/operations/seller/create_operation.rb'
    assert_file 'test/operations/seller/create_operation_test.rb'
  end
end
