# frozen_string_literal: true

module Supports
  module SidekiqMinitestSupport
    def after_teardown
      ::Sidekiq::Worker.clear_all
      super
    end
  end
end
