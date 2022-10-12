# frozen_string_literal: true

module Controllers
  module V1
    module Users
      class PasswordsController
        include Swagger::Blocks

        swagger_path '/v1/users/password' do
          operation :post do
            key :summary, 'Reset password'
            key :description, 'Send an email about resetting password'
            key :operationId, 'sendResetPasswordInformation'
            key :tags, [
              'User Passwords'
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
              key :description, 'Successful response'
              content :'application/json' do
                schema do
                  key :'$ref', :UserResetPasswordSuccessResponse
                end
              end
            end

            response 422 do
              key :description, 'Somethins goes wrong'
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

          operation :patch do
            key :summary, 'Update password'
            key :description, 'Update user password with token'
            key :operationId, 'updateUserPassword'
            key :tags, [
              'User Passwords'
            ]

            request_body do
              key :description, 'Password credentials'
              key :required, true
              content :'application/json' do
                schema do
                  key :'$ref', :UserUpdatePasswordInput
                end
              end
            end

            response 200 do
              key :description, 'Successful response'
              content :'application/json' do
                schema do
                  key :'$ref', :UserUpdatePasswordSuccessResponse
                end
              end
            end

            response 422 do
              key :description, 'Something goes wrong'
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
      end
    end
  end
end
