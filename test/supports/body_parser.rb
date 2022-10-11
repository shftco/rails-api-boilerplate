# frozen_string_literal: true

module Supports
  module BodyParser
    def load_body(response)
      JSON.parse(response.body, object_class: OpenStruct)
    end

    def errors_count(response)
      load_body(response).errors.count
    end

    def error_message?(response, message)
      load_body(response).errors.include?(message)
    end

    def parse_meta(response)
      body = load_body(response)

      body.meta
    end

    def pagination_present?(response)
      pagination = parse_meta(response).pagination
      expected_keys = %i[current previous next limit total_pages total_count]

      expected_keys == pagination.keys
    end
  end
end
