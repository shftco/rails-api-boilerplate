# frozen_string_literal: true

module CustomObjects
  module ParameterObject
    class Pagination < Base
      attribute :page, Types::Coercible::Integer.default(1)
      attribute :per_page, Types::Coercible::Integer.default(Kaminari.config.default_per_page)
    end
  end
end
