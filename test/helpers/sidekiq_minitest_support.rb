# frozen_string_literal: true

module Helpers
  module SidekiqMinitestSupport
    def after_teardown
      Sidekiq::Worker.clear_all
      super
    end
  end
end
