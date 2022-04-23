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
    run_generator ['Seller']

    %w[create update destroy list].each do |action|
      assert_file "app/services/seller_service/#{action}.rb"
      assert_file "test/services/seller_service/#{action}_test.rb"
    end
  end

  test 'generator creates service files with custom actions' do
    run_generator ['Seller', '--actions', %w[create update]]

    %w[create update].each do |action|
      assert_file "app/services/seller_service/#{action}.rb"
      assert_file "test/services/seller_service/#{action}_test.rb"
    end

    %w[destroy list].each do |action|
      assert_no_file "app/services/seller_service/#{action}.rb"
      assert_no_file "test/services/seller_service/#{action}_test.rb"
    end
  end

  test 'generator creates service files with using module name' do
    run_generator ['Seller::Manager']

    %w[create update destroy list].each do |action|
      assert_file "app/services/seller_service/manager/#{action}.rb"
      assert_file "test/services/seller_service/manager/#{action}_test.rb"
    end
  end
end
