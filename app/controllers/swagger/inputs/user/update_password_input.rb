# frozen_string_literal: true

module Swagger
  module Inputs
    module User
      class UpdatePasswordInput
        include Swagger::Blocks

        swagger_component do
          schema :UserUpdatePasswordInput do
            key :required, %i[reset_password_token password password_confirmation]

            property :reset_password_token do
              key :type, :string
              key :example, 'e7c8f8f0-e8e0-4b0f-b8b1-f8f8f8f8f8f8'
            end

            property :password do
              key :type, :string
              key :example, 'newpassword'
            end

            property :password_confirmation do
              key :type, :string
              key :example, 'newpassword'
            end
          end
        end
      end
    end
  end
end
