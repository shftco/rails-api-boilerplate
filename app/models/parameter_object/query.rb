# frozen_string_literal: true

class ParameterObject::Query
  attr_reader :query

  def initialize(query = nil)
    @query = query
  end
end
