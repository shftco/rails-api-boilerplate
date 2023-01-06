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
            totalPages: collection.total_pages,
            totalCount: collection.total_count
          }
        }
      end
    end
  end
end
