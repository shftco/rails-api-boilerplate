# frozen_string_literal: true

module Api
  module Shared
    class MetaBlueprint
      def self.render(collection)
        {
          pagination: {
            current: collection.current_page,
            previous: collection.prev_page,
            next: collection.next_page,
            limit: collection.limit_value,
            total_pages: collection.total_pages,
            total_count: collection.total_count,
            first_page: collection.first_page?,
            last_page: collection.last_page?
          }
        }
      end
    end
  end
end
