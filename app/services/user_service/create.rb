# frozen_string_literal: true

require 'dry/monads/do'

class UserService::Create
  include Dry::Monads[:result]
  include Dry::Monads::Do.for(:call)

  attr_reader :params

  def initialize(params:)
    @params = params
  end

  def call
    user = User.new(params)

    if user.save
      Success(user)
    else
      Failure([:error, user.errors])
    end
  end
end
