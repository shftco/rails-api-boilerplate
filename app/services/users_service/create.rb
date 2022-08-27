# frozen_string_literal: true

class UsersService::Create < ApplicationService
  include Dry::Monads[:result]
  include Dry::Monads::Do.for(:call)

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
