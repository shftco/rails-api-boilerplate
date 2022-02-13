# frozen_string_literal: true

module DoorkeeperRegisterable
  extend ActiveSupport::Concern

  def generate_refresh_token
    loop do
      # generate a random token string and return it
      # unless there is already another token with the same string
      token = SecureRandom.hex(32)
      break token unless Doorkeeper::AccessToken.exists?(refresh_token: token)
    end
  end

  def generate_access_token(user, client_app)
    Doorkeeper::AccessToken.create(
      resource_owner_id: user.id,
      resource_owner_type: user.class.name,
      application_id: client_app.id,
      refresh_token: generate_refresh_token,
      expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
      scopes: ''
    )
  end

  def render_user(user, client_app, token_type = 'Bearer')
    access_token = generate_access_token(user, client_app)

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
