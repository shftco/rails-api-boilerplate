# frozen_string_literal: true

module Responses
  module V1
    module User
      class SignUpResponse
        include Swagger::Blocks

        swagger_component do
          schema :UserSignUpSuccessResponse do
            key :type, :object
            key :required, %i[user access_token token_type expires_in refresh_token created_at]

            property :resource_owner do
              key :type, :object
              key :required, %i[id email created_at updated_at]

              property :id do
                key :type, :string
                key :format, :uuid
                key :example, 'e7c8f8f0-e8e0-4b0f-b8b1-f8f8f8f8f8f8'
              end

              property :email do
                key :type, :string
                key :example, 'test@test.com'
              end

              property :created_at do
                key :type, :datetime
                key :example, '2021-11-21T12:00:00.000Z'
              end

              property :updated_at do
                key :type, :datetime
                key :example, '2021-11-21T12:00:00.000Z'
              end
            end

            property :application do
              key :type, :object
              key :required, %i[id name created_at updated_at]

              property :id do
                key :type, :string
                key :format, :uuid
                key :example, 'e7c8f8f0-e8e0-4b0f-b8b1-f8f8f8f8f8f8'
              end

              property :name do
                key :type, :string
                key :example, 'Test App'
              end

              property :scopes do
                key :type, :string
                key :example, 'public'
              end

              property :created_at do
                key :type, :datetime
                key :example, '2021-11-21T12:00:00.000Z'
              end

              property :updated_at do
                key :type, :datetime
                key :example, '2021-11-21T12:00:00.000Z'
              end
            end

            property :token do
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
              key :example, 1_661_719_307
            end

            property :revoked_at do
              key :type, :datetime
              key :example, '2021-11-21T12:00:00.000Z'
            end

            property :id do
              key :type, :string
              key :format, :uuid
              key :example, 'e7c8f8f0-e8e0-4b0f-b8b1-f8f8f8f8f8f8'
            end
          end
        end
      end
    end
  end
end
