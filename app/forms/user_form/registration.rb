# frozen_string_literal: true

require 'reform/form/coercion'

class UserForm::Registration < Reform::Form
  feature Coercion

  property :email
  property :password

  validation do
    config.messages.backend = :i18n

    params do
      required(:email) { filled? }
      required(:password) { filled? & min_size?(Devise.password_length.min) }
    end

    rule(:email) do
      key.failure(:invalid?) if /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(value).blank?
    end
  end
end
