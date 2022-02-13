# frozen_string_literal: true

require "test_helper"
require "generators/form/form_generator"

class FormGeneratorTest < Rails::Generators::TestCase
  tests FormGenerator
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  test 'generator runs without errors' do
    assert_nothing_raised do
      run_generator ["Seller"]
    end
  end

  test 'generator creates form files' do
    run_generator ["Seller"]

    assert_file "app/forms/seller_form.rb"
  end

  test 'generator creates forms files with using module name' do
    run_generator ["Seller::Manager"]

    assert_file "app/forms/seller_form/manager.rb"
  end
end
