# frozen_string_literal: true

module Controllers
  module Users
    class RegistrationsController
      include Swagger::Blocks

      swagger_path '/users/sign_up' do
        operation :post do
          key :summary, 'Sign up'
          key :description, 'Create a new user and generate acess and refresh tokens'
          key :operationId, 'userSignUp'
          key :tags, [
            'user'
          ]

          request_body do
            key :description, 'User credentials'
            key :required, true
            content :'application/json' do
              schema do
                key :'$ref', :UserSignUpInput
              end
            end
          end

          response 201 do
            key :description, 'successfull response'
            content :'application/json' do
              schema do
                key :'$ref', :UserSignUpSuccessResponse
              end
            end
          end

          response 422 do
            key :description, 'error response'
            content :'application/json' do
              schema do
                key :'$ref', :UserSignUpErrorResponse
              end
            end
          end

          response 400 do
            key :description, 'invalid client response'
            content :'application/json' do
              schema do
                key :'$ref', :UserSignUpInvalidClientResponse
              end
            end
          end
        end
      end
    end
  end
end
