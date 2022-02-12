# frozen_string_literal: true

require "test_helper"
require "generators/service/service_generator"

class ServiceGeneratorTest < Rails::Generators::TestCase
  tests ServiceGenerator
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  test 'generator runs without errors' do
    assert_nothing_raised do
      run_generator ["User"]
    end
  end

  test 'generator creates service files' do
    run_generator ["User"]

    %w[create update destroy list].each do |action|
      assert_file "app/services/user_service/#{action}.rb"
    end
  end

  test 'generator creates service files with custom actions' do
    run_generator ["User", "--actions", %w[create update]]

    %w[create update].each do |action|
      assert_file "app/services/user_service/#{action}.rb"
    end

    %w[destroy list].each do |action|
      assert_no_file "app/services/user_service/#{action}.rb"
    end
  end

  test 'generator creates service files with using module name' do
    run_generator ["Facebook::Adset"]

    %w[create update destroy list].each do |action|
      assert_file "app/services/facebook_service/adset/#{action}.rb"
    end
  end
end
