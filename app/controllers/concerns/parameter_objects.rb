# frozen_string_literal: true

module ParameterObjects
  extend ActiveSupport::Concern

  included do
    def pagination_object
      page = params.fetch(:page, 1)
      per_page = params.fetch(:per_page, Kaminari.config.default_per_page)

      CustomObjects::ParameterObject::Pagination.new(page:, per_page:)
    end

    def query_object
      query = params.fetch(:query, {})

      CustomObjects::ParameterObject::Query.new(query:)
    end
  end
end
