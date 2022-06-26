# frozen_string_literal: true

class AuthenticatedController < ApplicationController
  # equivalent of authenticate_user! on devise, but this one will check the oauth token
  before_action :doorkeeper_authorize!

  around_action :switch_locale

  private

  # helper method to access the current user from the token
  def current_user
    @current_user ||= doorkeeper_token.resource_owner
  end

  def switch_locale(&action)
    locale = current_user.try(:locale) || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
end
