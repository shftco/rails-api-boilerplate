# frozen_string_literal: true

# https://github.com/doorkeeper-gem/doorkeeper/blob/main/lib/doorkeeper/oauth/token_response.rb
module Supports
  module Doorkeeper
    module CustomRegisterResponse
      def body(user, access_token, token_type = 'Bearer')
        {
          user: {
            id: user.id,
            type: user.class.name,
            email: user.email
          },
          access_token: access_token.token,
          token_type:,
          expires_in: access_token.expires_in,
          refresh_token: access_token.refresh_token,
          created_at: access_token.created_at.to_time.to_i
        }
      end
    end
  end
end
