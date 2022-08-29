# frozen_string_literal: true

module ParameterObject
  class Pagination
    attr_reader :page, :per_page

    def initialize(page = nil, per_page = 15)
      @page = page.to_i.presence.try(:nonzero?) || 1
      @per_page = per_page.to_i.presence.try(:nonzero?) || Kaminari.config.default_per_page
    end

    def unlimited!
      @page = nil
      @per_page = nil
    end
  end
end
