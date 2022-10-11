# frozen_string_literal: true

# rubocop:disable Metrics/ModuleLength
module Supports
  module ContractValidator
    include Supports::ApplicationContract::ErrorParser
    include Supports::ApplicationContract::I18n

    def success?(result, key, contract)
      assert_not_includes contract_error_messages(result, contract).keys, key
    end

    def filled?(result, key, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], I18n.t('dry_validation.errors.filled?')
    end

    def str?(result, key, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], I18n.t('dry_validation.errors.str?')
    end

    def max_size?(result, key, max_size, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], I18n.t('dry_validation.errors.max_size?', num: max_size)
    end

    def min_size?(result, key, min_size, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], I18n.t('dry_validation.errors.min_size?', num: min_size)
    end

    def size_range?(result, key, size_left, size_right, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], I18n.t('dry_validation.errors.size?.arg.range', size_left:, size_right:)
    end

    def eql?(result, key, left, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], I18n.t('dry_validation.errors.eql?', left:)
    end

    def not_eql?(result, key, left, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], I18n.t('dry_validation.errors.not_eql?', left:)
    end

    def included_in?(result, key, values, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], I18n.t('dry_validation.errors.included_in?.arg.default', list: values.join(', '))
    end

    def decimal?(result, key, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], I18n.t('dry_validation.errors.decimal?')
    end

    def int?(result, key, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], I18n.t('dry_validation.errors.int?')
    end

    def float?(result, key, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], I18n.t('dry_validation.errors.float?')
    end

    def filled_optional?(result, key, contract)
      assert_not_includes contract_error_messages(result, contract).keys, key
    end

    def format?(result, key, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], I18n.t('dry_validation.errors.format?')
    end

    def gteq?(result, key, num, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], I18n.t('dry_validation.errors.gteq?', num:)
    end

    def gt?(result, key, num, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], I18n.t('dry_validation.errors.gt?', num:)
    end

    def lt?(result, key, num, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], I18n.t('dry_validation.errors.lt?', num:)
    end

    def lteq?(result, key, num, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], I18n.t('dry_validation.errors.lteq?', num:)
    end

    def date?(result, key, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], I18n.t('dry_validation.errors.date?')
    end

    def date_time?(result, key, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], I18n.t('dry_validation.errors.date_time?')
    end

    def time?(result, key, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], I18n.t('dry_validation.errors.time?')
    end

    def invalid_with?(result, key, message, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], message
    end

    def array?(result, key, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], I18n.t('dry_validation.errors.array?')
    end

    def missing?(result, key, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], I18n.t('dry_validation.errors.key?')
    end

    def same_password?(result, key, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], I18n.t('dry_validation.errors.same_password?')
    end

    def uuid_v4?(result, key, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], I18n.t('dry_validation.errors.uuid_v4?')
    end

    def nil?(result, key, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], I18n.t('dry_validation.errors.nil?')
    end

    def type?(result, key, type, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], I18n.t('dry_validation.errors.type?', type:)
    end

    def hash?(result, key, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], I18n.t('dry_validation.errors.hash?')
    end

    def empty?(result, key, contract)
      assert_includes contract_error_messages(result, contract).keys, key
      assert_includes contract_error_messages(result, contract)[key], I18n.t('dry_validation.errors.not.empty?')
    end

    private

    def contract_error_messages(result, contract)
      errors = contract_errors_parser(contract_error_parser(result, contract))

      check_i18n_translations(errors)

      errors
    end
  end
end
# rubocop:enable Metrics/ModuleLength
