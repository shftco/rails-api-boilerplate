# frozen_string_literal: true

module Responses
  module Doorkeeper
    class InvalidResponse
      include Swagger::Blocks

      swagger_component do
        schema :DoorkeeperInvalidResponse do
          key :type, :object
          key :required, %i[error error_description]

          property :error do
            key :type, :string
          end

          property :error_description do
            key :type, :string
            key :example, 'Lorem ipsum dolor sit amet'
          end
        end
      end
    end
  end
end
