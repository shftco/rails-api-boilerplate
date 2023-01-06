# frozen_string_literal: true

module UsersService
  class Create < ApplicationService
    option :params, type: Types::Hash

    def call
      user = yield create_user

      Success(user)
    end

    private

    def create_user
      user = User.new(params)

      return Success(user) if user.save

      resource_failure(user)
    end
  end
end
