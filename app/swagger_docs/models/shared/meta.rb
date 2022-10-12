# frozen_string_literal: true

module Models
  module Shared
    class Meta
      include Swagger::Blocks

      swagger_component do
        schema :Meta do
          key :type, :object
          key :required, %i[pagination]

          property :pagination do
            key :'$ref', :Pagination
          end
        end
      end
    end
  end
end
