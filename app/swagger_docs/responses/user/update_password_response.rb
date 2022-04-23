# frozen_string_literal: true

module Responses
  module User
    class UpdatePasswordResponse
      include Swagger::Blocks

      swagger_component do
        schema :UserUpdatePasswordSuccessResponse do
          key :type, :object
          key :required, %i[message]

          property :message do
            key :type, :string
            key :example, 'Your password has been changed successfully.'
          end
        end

        schema :UserUpdatePasswordErrorResponse do
          key :type, :object
          key :required, %i[errors]

          property :errors do
            key :type, :object

            property :reset_password_token do
              key :type, :array
              items do
                key :type, :string
                key :example, 'is invalid'
              end
            end
          end
        end
      end
    end
  end
end
