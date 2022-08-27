# frozen_string_literal: true

require 'dry-types'

module Types
  include Dry.Types()

  Email = String.constrained(format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
end
