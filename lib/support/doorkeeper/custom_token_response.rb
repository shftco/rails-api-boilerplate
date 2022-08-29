# frozen_string_literal: true

module Doorkeeper
  module CustomTokenResponse
    def body
      current_user = @token.resource_owner

      additional_data = {
        user: {
          id: current_user.id,
          type: current_user.class.name,
          email: current_user.email
        }
      }

      super.merge(additional_data)
    end
  end
end
