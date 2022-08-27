# frozen_string_literal: true

class ApplicationController < ActionController::API
  private

  def pagination_object
    ParameterObject::Pagination.new(params[:page], params[:per_page])
  end

  def query_object
    ParameterObject::Query.new(params[:query])
  end
end
