# frozen_string_literal: true

# https://github.com/doorkeeper-gem/doorkeeper/blob/main/lib/doorkeeper/oauth/token_response.rb
module Supports
  module Sidekiq
    module Helper
      def job_params_handler(**params)
        data = (params || {}).to_json

        JSON.parse(data)
      end

      def updated_resource_payload(newest, oldest)
        old_attributes = newest.previous_changes.except(:updated_at).transform_values(&:first)
        new_attributes = oldest.attributes.slice(*old_attributes.keys)

        job_params_handler(new_attributes:, old_attributes:)
      end
    end
  end
end
