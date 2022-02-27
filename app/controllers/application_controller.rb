# frozen_string_literal: true

class ApplicationController < ActionController::API
  # equivalent of authenticate_user! on devise, but this one will check the oauth token
  before_action :doorkeeper_authorize!

  private

  # helper method to access the current user from the token
  def current_user
    @current_user ||= doorkeeper_token.resource_owner
  end

  def pagination_object
    ParameterObject::Pagination.new(params[:page], params[:per_page])
  end

  def query_object
    ParameterObject::Query.new(params[:query])
  end

  def to_json_form_errors(record)
    errors = {}

    record.errors.messages.each do |key, messages|
      messages.each do |message|
        errors[key] = errors.fetch(key, []) << message
      end
    end

    { errors: }.to_json
  end
end
