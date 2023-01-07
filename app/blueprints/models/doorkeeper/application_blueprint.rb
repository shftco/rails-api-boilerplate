# frozen_string_literal: true

module Models
  module Doorkeeper
    class ApplicationBlueprint < Blueprinter::Base
      identifier :id

      view :standard do
        fields :name, :uid, :secret, :redirect_uri, :scopes, :confidential, :created_at, :updated_at
      end

      view :without_secrets do
        include_view :standard

        excludes :uid, :secret, :redirect_uri, :confidential
      end
    end
  end
end
