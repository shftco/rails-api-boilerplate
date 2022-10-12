# frozen_string_literal: true

module Inputs
  module V1
    module User
      class SignInInput
        include Swagger::Blocks

        swagger_component do
          schema :UserSignInInput do
            key :required, %i[grant_type email password client_id client_secret]

            property :grant_type do
              key :type, :string
              key :example, 'password'
            end

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
