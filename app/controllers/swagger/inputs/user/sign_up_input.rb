# frozen_string_literal: true

module Swagger
  module Inputs
    module User
      class SignUpInput
        include Swagger::Blocks

        swagger_component do
          schema :UserSignUpInput do
            key :required, %i[email password client_id]

            property :email do
              key :type, :string
              key :example, 'test@test.com'
            end

            property :password do
              key :type, :string
              key :example, 'password'
            end

            property :client_id do
              key :type, :string
              key :example, 'e7c8f8f0-e8e0-4b0f-b8b1-f8f8f8f8f8f8'
            end
          end
        end
      end
    end
  end
end
