# frozen_string_literal: true

# https://github.com/doorkeeper-gem/doorkeeper/blob/main/lib/doorkeeper/oauth/token_response.rb
module Overrides
  module Doorkeeper
    module TokenResponseDecorator
      def body
        Models::Doorkeeper::AccessTokenBlueprint.render_as_hash(@token, view: :with_resource_owner_and_application)
      end
    end
  end
end
