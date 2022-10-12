# frozen_string_literal: true

module Responses
  module Shared
    class ErrorResponse
      include Swagger::Blocks

      swagger_component do
        schema :ErrorResponse do
          key :type, :object

          property :errors do
            key :type, :array
            items do
              key :type, :string
              key :example, 'Something goes wrong while executing request'
            end
          end
        end
      end
    end
  end
end
