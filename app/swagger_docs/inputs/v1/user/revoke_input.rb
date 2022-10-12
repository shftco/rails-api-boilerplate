# frozen_string_literal: true

module Inputs
  module V1
    module User
      class RevokeInput
        include Swagger::Blocks

        swagger_component do
          schema :UserRevokeInput do
            key :required, %i[token client_id client_secret]

            property :token do
              key :type, :string
              key :example, '1qaz2wsx3edc'
            end

            property :client_id do
              key :type, :string
              key :example, 'e7c8f8f0-e8e0-4b0f-b8b1-f8f8f8f8f8f8'
            end

            property :client_secret do
              key :type, :string
              key :example, 'e7c8f8f0-e8e0-4b0f-b8b1-f8f8f8f8f8f8'
            end
          end
        end
      end
    end
  end
end
