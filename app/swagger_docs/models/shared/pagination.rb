# frozen_string_literal: true

module Models
  module Shared
    class Pagination
      include Swagger::Blocks

      swagger_component do
        schema :Pagination do
          key :type, :object
          key :required, %i[current limit total_pages total_count]

          property :current do
            key :type, :integer
            key :format, :int32
          end

          property :previous do
            key :type, :integer
            key :format, :int32
          end

          property :next do
            key :type, :integer
            key :format, :int32
          end

          property :limit do
            key :type, :integer
            key :format, :int32
          end

          property :total_pages do
            key :type, :integer
            key :format, :int32
          end

          property :total_count do
            key :type, :integer
            key :format, :int64
          end
        end
      end
    end
  end
end
