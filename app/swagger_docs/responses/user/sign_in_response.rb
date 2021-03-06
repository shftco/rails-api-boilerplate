# frozen_string_literal: true

module Responses
  module User
    class SignInResponse
      include Swagger::Blocks

      swagger_component do
        schema :UserSignInSuccessResponse do
          key :type, :object
          key :required, %i[access_token token_type expires_in refresh_token created_at]

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
            key :example, 157
          end
        end

        schema :UserSignInErrorResponse do
          key :type, :object
          key :required, %i[error error_description]

          property :error do
            key :type, :string
            key :example, 'invalid_grant'
          end

          property :error_description do
            key :type, :string
            key :example, 'Client authentication failed due to unknown client, no client authentication included, or unsupported authentication method.'
          end
        end
      end
    end
  end
end
