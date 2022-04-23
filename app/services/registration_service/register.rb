# frozen_string_literal: true

require 'dry/monads/do'

class RegistrationService::Register
  include Dry::Monads[:result]
  include Dry::Monads::Do.for(:call)

  attr_reader :params

  def initialize(params:)
    @params = params
  end

  def call
    ActiveRecord::Base.transaction(requires_new: true) do
      user = yield call_create_user

      Success(user)
    end
  end

  private

  def call_create_user
    UserService::Create.new(params:).call
  end
end
