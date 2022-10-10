# frozen_string_literal: true

module Users
  class CreateService < ApplicationService
    option :params, type: Types::Hash

    def call
      user = User.new(params)

      if user.save
        Success(user)
      else
        resource_failure(user)
      end
    end
  end
end
