# frozen_string_literal: true

require 'dry-struct'

module CustomObjects
  class Base < Dry::Struct
    transform_keys(&:to_sym)
  end
end
