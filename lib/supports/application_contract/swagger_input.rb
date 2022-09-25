# frozen_string_literal: true

require 'active_support/all'

module Supports
  module ApplicationContract
    module SwaggerInput
      extend ActiveSupport::Concern

      module ClassMethods
        def _swagger_nodes
          { component_node: OpenStruct.new(data: component_node_data) }
        end

        def contract_classes
          Dir[Rails.root.join('app/contracts/**/*_contract.rb')].map do |path|
            klass = path.split('/app/contracts/')
                        .last
                        .rpartition('.')
                        .first
                        .classify
                        .constantize

            next if klass.eql?(::ApplicationContract)

            klass
          end.reject(&:blank?)
        end

        private

        def custom_schema_name
          "#{self.name.gsub('::','')}Input".to_sym
        end
  
        def custom_json_schema
          json_schema = self.schema.json_schema(loose: true)

          {
            type: json_schema[:type],
            properties: json_schema[:properties],
            required: json_schema[:required]
          }
        end

        def component_node_data
          { schemas: { "#{custom_schema_name}": custom_json_schema } }
        end
      end
    end
  end
end
