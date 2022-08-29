# frozen_string_literal: true

module Authenticable
  extend ActiveSupport::Concern

  included do
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable,
           :trackable
  end

  module ClassMethods
    # rubocop:disable Style/RedundantSelf
    def authenticate(email, password)
      user = self.find_for_authentication(email:)
      user&.valid_password?(password) ? user : nil
    end
    # rubocop:enable Style/RedundantSelf
  end
end
