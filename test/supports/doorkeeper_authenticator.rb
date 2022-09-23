# frozen_string_literal: true

module Supports
  module DoorkeeperAuthenticator
    def oauth_token_params(user, application, grant_type = ::Doorkeeper.config.grant_flows.first)
      {
        grant_type:,
        email: user.email,
        password: user.password,
        client_id: application.uid,
        client_secret: application.secret
      }
    end

    def oauth_revoke_params(token, token_type = 'token', grant_type = 'refresh_token')
      {
        grant_type:,
        token: token.try(token_type),
        client_id: token.application.uid,
        client_secret: token.application.secret
      }
    end

    def oauth_refresh_token_params(token, token_type = 'refresh_token')
      {
        grant_type: 'refresh_token',
        refresh_token: token.try(token_type),
        client_id: token.application.uid,
        client_secret: token.application.secret
      }
    end

    def authorization_header(token)
      { 'Authorization' => "Bearer #{token.token}" }
    end
  end
end
