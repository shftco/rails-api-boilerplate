# frozen_string_literal: true

require 'oj'

Blueprinter.configure do |config|
  config.generator = Oj # default is JSON
end
