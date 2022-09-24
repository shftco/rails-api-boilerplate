# frozen_string_literal: true

module ParameterObjects
  extend ActiveSupport::Concern

  included do
    def pagination_object
      CustomObjects::ParameterObject::Pagination.new(page: params[:page],
                                                     per_page: params[:per_page])
    end

    def query_object
      CustomObjects::ParameterObject::Query.new(query: params[:query])
    end
  end
end
