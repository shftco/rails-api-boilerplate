# frozen_string_literal: true

module Controllers
  module V1
    module Users
      class TokensController
        include Swagger::Blocks

        swagger_path '/v1/users/oauth/token' do
          operation :post do
            key :summary, 'Generate access and refresh tokens for authentication'
            key :description, 'Generate access and refresh tokens for authentication'
            key :operationId, 'userSignIn'
            key :tags, [
              'User Sessions'
            ]

            request_body do
              key :description, 'User credentials'
              key :required, true
              content :'application/json' do
                schema do
                  key :'$ref', :UserSignInInput
                end
              end
            end

            response 200 do
              key :description, 'Successful response'
              content :'application/json' do
                schema do
                  key :'$ref', :UserSignInSuccessResponse
                end
              end
            end

            response 400 do
              key :description, 'Invalid authentication credentials passed'
              content :'application/json' do
                schema do
                  key :'$ref', :ErrorResponse
                end
              end
            end

            response 401 do
              key :description, 'Invalid client credentials passed'
              content :'application/json' do
                schema do
                  key :'$ref', :ErrorResponse
                end
              end
            end
          end
        end

        swagger_path '/v1/users/oauth/revoke' do
          operation :post do
            key :summary, 'Revoke access or refresh tokens'
            key :description, 'Revoke access or refresh token'
            key :operationId, 'userLogout'
            key :tags, [
              'User Sessions'
            ]

            request_body do
              key :description, 'Token credentials'
              key :required, true
              content :'application/json' do
                schema do
                  key :'$ref', :UserRevokeInput
                end
              end
            end

            response 200 do
              key :description, 'Default response'
              content :'application/json' do
                schema do
                  key :type, :object
                end
              end
            end

            response 403 do
              key :description, 'Invalid client credentials passed'
              content :'application/json' do
                schema do
                  key :'$ref', :ErrorResponse
                end
              end
            end
          end
        end
      end
    end
  end
end
