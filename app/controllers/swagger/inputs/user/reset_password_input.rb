# frozen_string_literal: true

module Swagger
  module Inputs
    module User
      class ResetPasswordInput
        include Swagger::Blocks

        swagger_component do
          schema :UserResetPasswordInput do
            key :required, %i[email]

            property :email do
              key :type, :string
              key :example, 'test@test.com'
            end
          end
        end
      end
    end
  end
end
