# frozen_string_literal: true

module Supports
  module BodyParser
    def load_body(response)
      JSON.parse(response.body, symbolize_names: true)
    end

    def errors_count(response)
      load_body(response)[:errors].count
    end

    def error_message?(response, message)
      load_body(response)[:errors].include?(message)
    end
  end
end
