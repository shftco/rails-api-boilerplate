# frozen_string_literal: true

module Supports
  module ApplicationContract
    module ErrorParser
      TEST_KEYS_SPLITTER = '_of_'

      def contract_error_parser(contract_result, contract)
        errors = contract_result.errors.to_h
        total_errors = []

        errors.each do |key, val|
          total_errors.push(extracts_errors(contract, key, val))
        end

        { errors: total_errors.flatten }
      end

      private

      def extracts_errors(contract, key, val, top_keys = [])
        return handle_error(top_keys.concat([key]), val.first) if val.is_a?(Array)

        val.map do |k, v|
          extracts_errors(contract, k, v, top_keys.concat([key]))
        end
      end

      def handle_error(keys, val)
        if Rails.env.test?
          {
            "#{keys.uniq.reverse.join(TEST_KEYS_SPLITTER).to_sym}": val
          }
        else
          localize_error_message(keys, val)
        end
      end

      def localize_error_message(keys, val)
        case I18n.locale
        when :tr
          "#{localize_params(keys).reverse.join(keys_splitter)} #{val}"
        when :en
          "#{localize_params(keys).join(keys_splitter)} #{val}"
        else
          raise "Unsupported locale #{I18n.locale}"
        end
      end

      def localize_params(keys)
        case I18n.locale
        when :tr
          keys.map { |k| I18n.t("contracts.params.#{k}").capitalize }
        when :en
          keys.map(&:capitalize)
        else
          raise "Unsupported locale #{I18n.locale}"
        end
      end

      def format_contract_name(contract)
        contract.class.name.parameterize.tr('-', '.')
      end

      def keys_splitter(locale = I18n.locale)
        I18n.t('dry_validation.keys_splitter', locale:)
      end
    end
  end
end
