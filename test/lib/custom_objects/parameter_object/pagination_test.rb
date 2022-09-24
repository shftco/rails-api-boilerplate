# frozen_string_literal: true

require 'test_helper'

module CustomObjects
  module ParameterObject
    class PaginationTest < ActiveSupport::TestCase
      test 'default values' do
        pagination = CustomObjects::ParameterObject::Pagination.new

        assert_equal 1, pagination.page
        assert_equal 25, pagination.per_page
      end

      test 'page' do
        pagination = CustomObjects::ParameterObject::Pagination.new(page: 2)
        pagination_coercible = CustomObjects::ParameterObject::Pagination.new(page: '2')

        assert_equal 2, pagination.page
        assert_equal 2, pagination_coercible.page
      end

      test 'per page' do
        pagination = CustomObjects::ParameterObject::Pagination.new(per_page: 2)
        pagination_coercible = CustomObjects::ParameterObject::Pagination.new(per_page: '2')

        assert_equal 2, pagination.per_page
        assert_equal 2, pagination_coercible.per_page
      end
    end
  end
end
