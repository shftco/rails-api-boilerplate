# frozen_string_literal: true

module Responses
  module User
    class SignUpResponse
      include Swagger::Blocks

      swagger_component do
        schema :UserSignUpSuccessResponse do
          key :type, :object
          key :required, %i[id email access_token token_type expires_in created_at]

          property :user do
            key :type, :object

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

          property :created_at do
            key :type, :string
            key :format, :date_time
            key :example, '2020-01-01T00:00:00.000Z'
          end
        end

        schema :UserSignUpErrorResponse do
          key :type, :object
          key :required, %i[errors]

          property :errors do
            key :type, :object

            property :email do
              key :type, :array
              items do
                key :type, :string
                key :example, 'has already been taken'
              end
            end
          end
        end

        schema :UserSignUpInvalidClientResponse do
          key :type, :object
          key :required, %i[errors]

          property :errors do
            key :type, :object

            property :client do
              key :type, :array
              items do
                key :type, :string
                key :example, 'Client authentication failed due to unknown client, no client authentication included, or unsupported authentication method.'
              end
            end
          end
        end
      end
    end
  end
end
