# frozen_string_literal: true

class UserService::Create < Base
  include Dry::Monads[:result]
  include Dry::Monads::Do.for(:call)

  option :params, type: Types::Hash

  def call
    user = User.new(params)

    if user.save
      Success(user)
    else
      Failure([:error, user.errors])
    end
  end
end
