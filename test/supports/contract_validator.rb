# frozen_string_literal: true

# rubocop:disable Metrics/ModuleLength
module Supports
  module ContractValidator
    include Supports::ApplicationContract::ErrorParser

    def success?(result, key, contract)
      assert_not_includes contract_error_messages(result, contract).keys, key
    end

    def filled?(result, key, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], 'must be filled'
    end

    def str?(result, key, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], 'must be a string'
    end

    def max_size?(result, key, max_size, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], "can't be longer than #{max_size} characters"
    end

    def min_size?(result, key, min_size, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], "size cannot be less than #{min_size}"
    end

    def min_max_size?(result, key, min_size, max_size, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], "size must be within #{min_size} - #{max_size}"
    end

    def eql?(result, key, eql, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], "must be equal to #{eql}"
    end

    def included_in?(result, key, values, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], "must be one of: #{values.join(', ')}"
    end

    def decimal?(result, key, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], 'must be a decimal'
    end

    def int?(result, key, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], 'must be an integer'
    end

    def float?(result, key, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], 'must be a float'
    end

    def filled_optional?(result, key, contract)
      assert_not_includes contract_error_messages(result, contract).keys, key
    end

    def size?(result, key, size)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], "Must be #{size} digits"
    end

    def format?(result, key, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], 'is in invalid format'
    end

    def gteq?(result, key, num, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], "must be greater than or equal to #{num}"
    end

    def gt?(result, key, num, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], "must be greater than #{num}"
    end

    def lt?(result, key, num, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], "must be less than #{num}"
    end

    def lteq?(result, key, num, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], "must be less than or equal to #{num}"
    end

    def date_time?(result, key, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], 'must be a date/time'
    end

    def time?(result, key, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], 'must be time'
    end

    def invalid?(result, key, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], 'invalid'
    end

    def invalid_with?(result, key, message, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], message
    end

    def array?(result, key, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], 'must be an array'
    end

    def missing?(result, key, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], 'is missing'
    end

    def same_password?(result, key, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], 'does not match'
    end

    def uuid_v4?(result, key, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], 'is not a valid UUID'
    end

    private

    def contract_error_messages(result, contract)
      errors = contract_errors_parser(contract_error_parser(result, contract))

      check_i18n_translations(contract, errors)

      errors
    end

    def check_i18n_translations_for(contract, errors, locale)
      params = errors.keys.map { |k| k.to_s.split(Supports::ApplicationContract::ErrorParser::TEST_KEYS_SPLITTER) }.flatten

      params.each do |param|
        translation = I18n.t("contracts.#{format_contract_name(contract)}.params.#{param}", locale:)
        ap translation if translation.include?('translation missing')
      end
    end

    def check_i18n_translations(contract, errors)
      I18n.available_locales.each do |locale|
        next if locale == :en

        check_i18n_translations_for(contract, errors, locale)
      end
    end
  end
end
# rubocop:enable Metrics/ModuleLength
