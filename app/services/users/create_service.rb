# frozen_string_literal: true

module Users
  class CreateService < ApplicationService
    option :params, type: Types::Hash

    def call
      user = yield create_resource(User)

      Success(user)
    end
  end
end
