# frozen_string_literal: true

# rubocop:disable Metrics/ModuleLength
module Helpers
  module FormValidator
    def success?(validator, key)
      assert_not_includes form_error_messages(validator).keys, key
    end

    def filled?(validator, key)
      assert_includes form_error_messages(validator).keys, key
      assert_includes form_error_messages(validator)[key], 'must be filled'
    end

    def str?(validator, key)
      assert_includes form_error_messages(validator).keys, key
      assert_includes form_error_messages(validator)[key], 'must be a string'
    end

    def max_size?(validator, key, max_size)
      assert_includes form_error_messages(validator).keys, key
      assert_includes form_error_messages(validator)[key], "can't be longer than #{max_size} characters"
    end

    def min_size?(validator, key, min_size)
      assert_includes form_error_messages(validator).keys, key
      assert_includes form_error_messages(validator)[key], "size cannot be less than #{min_size}"
    end

    def min_max_size?(validator, key, min_size, max_size)
      assert_includes form_error_messages(validator).keys, key
      assert_includes form_error_messages(validator)[key], "size must be within #{min_size} - #{max_size}"
    end

    def eql?(validator, key, eql)
      assert_includes form_error_messages(validator).keys, key
      assert_includes form_error_messages(validator)[key], "must be equal to #{eql}"
    end

    def included_in?(validator, key, values)
      assert_includes form_error_messages(validator).keys, key
      assert_includes form_error_messages(validator)[key], "must be one of: #{values.join(', ')}"
    end

    def decimal?(validator, key)
      assert_includes form_error_messages(validator).keys, key
      assert_includes form_error_messages(validator)[key], 'must be a decimal'
    end

    def int?(validator, key)
      assert_includes form_error_messages(validator).keys, key
      assert_includes form_error_messages(validator)[key], 'must be an integer'
    end

    def float?(validator, key)
      assert_includes form_error_messages(validator).keys, key
      assert_includes form_error_messages(validator)[key], 'must be a float'
    end

    def filled_optional?(validator, key)
      assert_not_includes form_error_messages(validator).keys, key
    end

    def size?(validator, key, size)
      assert_includes form_error_messages(validator).keys, key
      assert_includes form_error_messages(validator)[key], "Must be #{size} digits"
    end

    def format?(validator, key)
      assert_includes form_error_messages(validator).keys, key
      assert_includes form_error_messages(validator)[key], 'is in invalid format'
    end

    def gteq?(validator, key, num)
      assert_includes form_error_messages(validator).keys, key
      assert_includes form_error_messages(validator)[key], "must be greater than or equal to #{num}"
    end

    def gt?(validator, key, num)
      assert_includes form_error_messages(validator).keys, key
      assert_includes form_error_messages(validator)[key], "must be greater than #{num}"
    end

    def lt?(validator, key, num)
      assert_includes form_error_messages(validator).keys, key
      assert_includes form_error_messages(validator)[key], "must be less than #{num}"
    end

    def lteq?(validator, key, num)
      assert_includes form_error_messages(validator).keys, key
      assert_includes form_error_messages(validator)[key], "must be less than or equal to #{num}"
    end

    def date_time?(validator, key)
      assert_includes form_error_messages(validator).keys, key
      assert_includes form_error_messages(validator)[key], 'must be a date/time'
    end

    def time?(validator, key)
      assert_includes form_error_messages(validator).keys, key
      assert_includes form_error_messages(validator)[key], 'must be time'
    end

    def invalid?(validator, key)
      assert_includes form_error_messages(validator).keys, key
      assert_includes form_error_messages(validator)[key], 'invalid'
    end

    def invalid_with?(validator, key, message)
      assert_includes form_error_messages(validator).keys, key
      assert_includes form_error_messages(validator)[key], message
    end

    def array?(validator, key)
      assert_includes form_error_messages(validator).keys, key
      assert_includes form_error_messages(validator)[key], 'must be an array'
    end

    def missing?(validator, key)
      assert_includes form_error_messages(validator).keys, key
      assert_includes form_error_messages(validator)[key], 'is missing'
    end

    private

    def form_error_messages(validator)
      check_i18n_translations(validator, :tr)

      errors = {}

      validator.to_result.failure?&.errors&.each do |error|
        next if error.text.blank?

        error_key = error.path.reverse.map(&:to_s).join('_of_').to_sym
        errors[error_key] = errors.fetch(error_key, []) << error.text
      end

      errors
    end

    def split_error_path(validator)
      paths = []

      validator.to_result.failure?&.errors&.each do |error|
        next if error.text.blank?

        paths << error.path.last
      end

      paths
    end

    def check_i18n_translations(validator, locale)
      split_error_path(validator).each do |path|
        translation = I18n.t("forms.#{validator.class.to_s.underscore}.attributes.#{path}", locale:)
        ap translation if translation.include?('translation missing')
      end
    end
  end
end
# rubocop:enable Metrics/ModuleLength
