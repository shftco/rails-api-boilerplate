# frozen_string_literal: true

module Swagger
  module Controllers
    module Users
      class PasswordsController
        include Swagger::Blocks

        swagger_path '/users/password' do
          operation :post do
            key :summary, 'Reset password'
            key :description, 'Send an email about resetting password'
            key :operationId, 'userResetPassword'
            key :tags, [
              'user'
            ]

            request_body do
              key :description, 'User email'
              key :required, true
              content :'application/json' do
                schema do
                  key :'$ref', :UserResetPasswordInput
                end
              end
            end

            response 200 do
              key :description, 'successfull response'
              content :'application/json' do
                schema do
                  key :'$ref', :UserResetPasswordSuccessResponse
                end
              end
            end

            response 422 do
              key :description, 'error response'
              content :'application/json' do
                schema do
                  key :'$ref', :UserResetPasswordErrorResponse
                end
              end
            end
          end
        end

        swagger_path '/users/password' do
          operation :patch do
            key :summary, 'Update password'
            key :description, 'Update user password with token'
            key :operationId, 'userUpdatePassword'
            key :tags, [
              'user'
            ]

            request_body do
              key :description, 'User credentials'
              key :required, true
              content :'application/json' do
                schema do
                  key :'$ref', :UserUpdatePasswordInput
                end
              end
            end

            response 200 do
              key :description, 'successfull response'
              content :'application/json' do
                schema do
                  key :'$ref', :UserUpdatePasswordSuccessResponse
                end
              end
            end

            response 422 do
              key :description, 'error response'
              content :'application/json' do
                schema do
                  key :'$ref', :UserUpdatePasswordErrorResponse
                end
              end
            end
          end
        end
      end
    end
  end
end
