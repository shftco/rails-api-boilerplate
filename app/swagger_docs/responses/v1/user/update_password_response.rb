# frozen_string_literal: true

module Responses
  module V1
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
        end
      end
    end
  end
end
