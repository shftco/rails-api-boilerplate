# frozen_string_literal: true

module Supports
  module ApplicationContract
    module I18n
      # rubocop:disable Rails/Output
      def check_i18n_translations_for(errors, locale)
        params = errors.keys.map { |k| k.to_s.split(Supports::ApplicationContract::ErrorParser::TEST_KEYS_SPLITTER) }.flatten

        params.each do |param|
          translation = ::I18n.t("contracts.params.#{param}", locale:)
          ap(translation, { color: { string: :red } }) if translation.include?('translation missing')
        end
      end
      # rubocop:enable Rails/Output

      def check_i18n_translations(errors)
        ::I18n.available_locales.each do |locale|
          next if locale == :en

          check_i18n_translations_for(errors, locale)
        end
      end
    end
  end
end
