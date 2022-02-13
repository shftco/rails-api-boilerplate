# frozen_string_literal: true

module Helpers
  module BodyParser
    def load_body(response)
      JSON.parse(response.body, symbolize_names: true)
    end

    def error_count(response)
      load_body(response)[:errors].count
    end

    def error?(response, key)
      load_body(response)[:errors].key?(key)
    end

    def error_messages(response, key)
      load_body(response)[:errors][key]
    end

    def error_message?(response, key, message)
      error_messages(response, key).include?(message)
    end
  end
end
