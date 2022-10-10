# frozen_string_literal: true

require 'test_helper'
require 'generators/contract/contract_generator'

class ContractGeneratorTest < Rails::Generators::TestCase
  tests ContractGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  test 'generator runs without errors' do
    assert_nothing_raised do
      run_generator ['Customer']
    end
  end

  test 'generator creates contract' do
    run_generator ['Customer::Create']

    assert_file 'app/contracts/customer/create_contract.rb'
    assert_file 'test/contracts/customer/create_contract_test.rb'
  end
end
