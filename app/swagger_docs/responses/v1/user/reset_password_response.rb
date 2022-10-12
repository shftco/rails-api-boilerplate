# frozen_string_literal: true

module Responses
  module V1
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
        end
      end
    end
  end
end
