# frozen_string_literal: true

require 'test_helper'
require 'generators/service/service_generator'

class ServiceGeneratorTest < Rails::Generators::TestCase
  tests ServiceGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  test 'generator runs without errors' do
    assert_nothing_raised do
      run_generator ['Seller']
    end
  end

  test 'generator creates service files' do
    run_generator ['Seller::Create']

    assert_file 'app/services/seller/create_service.rb'
    assert_file 'test/services/seller/create_service_test.rb'
  end
end
