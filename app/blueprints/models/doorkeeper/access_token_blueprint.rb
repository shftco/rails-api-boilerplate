# frozen_string_literal: true

module Models
  module Doorkeeper
    class AccessTokenBlueprint < Blueprinter::Base
      identifier :id

      view :standard do
        fields :token, :refresh_token, :expires_in, :created_at, :revoked_at, :token_type
      end

      view :with_resource_owner do
        association :resource_owner, blueprint: Models::UserBlueprint, view: :standard
      end

      view :with_application do
        association :application, blueprint: Models::Doorkeeper::ApplicationBlueprint, view: :without_secrets
      end

      view :with_resource_owner_and_application do
        include_view :with_resource_owner
        include_view :with_application
        include_view :standard

        exclude :revoked_at
      end
    end
  end
end
