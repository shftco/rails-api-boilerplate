# frozen_string_literal: true

module Controllers
  module Users
    class TokensController
      include Swagger::Blocks

      swagger_path '/users/oauth/token' do
        operation :post do
          key :summary, 'Login '
          key :description, 'Generate acess and refresh tokens for authentication'
          key :operationId, 'userSignIn'
          key :tags, [
            'user'
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
            key :description, 'successfull response'
            content :'application/json' do
              schema do
                key :'$ref', :UserSignInSuccessResponse
              end
            end
          end

          response 401 do
            key :description, 'error response'
            content :'application/json' do
              schema do
                key :'$ref', :UserSignInErrorResponse
              end
            end
          end
        end
      end
    end
  end
end
