# frozen_string_literal: true

module Responses
  module V1
    module User
      class SignInResponse
        include Swagger::Blocks

        swagger_component do
          schema :UserSignInSuccessResponse do
            key :type, :object
            key :required, %i[access_token token_type expires_in refresh_token created_at user]

            property :access_token do
              key :type, :string
              key :example, 'e7c8f8f0-e8e0-4b0f-b8b1-f8f8f8f8f8f8'
            end

            property :token_type do
              key :type, :string
              key :example, 'Bearer'
            end

            property :expires_in do
              key :type, :integer
              key :example, 7200
            end

            property :refresh_token do
              key :type, :string
              key :example, 'e7c8f8f0-e8e0-4b0f-b8b1-f8f8f8f8f8f8'
            end

            property :created_at do
              key :type, :integer
              key :example, 1_661_719_659
            end

            property :user do
              key :type, :object
              key :required, %i[id type email]

              property :id do
                key :type, :string
                key :format, :uuid
                key :example, 'e7c8f8f0-e8e0-4b0f-b8b1-f8f8f8f8f8f8'
              end

              property :type do
                key :type, :string
                key :example, 'User'
              end

              property :email do
                key :type, :string
                key :example, 'test@test.com'
              end
            end
          end
        end
      end
    end
  end
end
