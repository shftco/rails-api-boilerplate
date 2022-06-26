# frozen_string_literal: true

class ApplicationController < ActionController::API
  include FormValidatorHelper

  private

  def pagination_object
    ParameterObject::Pagination.new(params[:page], params[:per_page])
  end

  def query_object
    ParameterObject::Query.new(params[:query])
  end

  def to_json_form_errors(form)
    errors = form_errors_to_json(form)

    { errors: }.to_json
  end
end
