# frozen_string_literal: true

require 'test_helper'

module CustomObjects
  module ParameterObject
    class QueryTest < ActiveSupport::TestCase
      test 'default values' do
        query = CustomObjects::ParameterObject::Query.new

        assert_empty query.query
      end
    end
  end
end
