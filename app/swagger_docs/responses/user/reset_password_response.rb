# frozen_string_literal: true

module Responses
  module User
    class ResetPasswordResponse
      include Swagger::Blocks

      swagger_component do
        schema :UserResetPasswordSuccessResponse do
          key :type, :object
          key :required, %i[message]

          property :message do
            key :type, :string
            key :example, 'You will receive an email with instructions on how to reset your password in a few minutes.'
          end
        end

        schema :UserResetPasswordErrorResponse do
          key :type, :object
          key :required, %i[error]

          property :errors do
            key :type, :object

            property :email do
              key :type, :array
              items do
                key :type, :string
                key :example, 'not found'
              end
            end
          end
        end
      end
    end
  end
end
