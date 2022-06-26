# frozen_string_literal: true

# rubocop:disable Metrics/ModuleLength
module Helpers
  module FormValidator
    def success?(validator, key, sub_error: false)
      if ActiveRecord::Type::Boolean.new.cast(sub_error)
        assert_not_includes error_messages(validator).keys, key
      else
        assert_not_includes validator.errors.messages.keys, key
      end
    end

    def filled?(validator, key, sub_error: false)
      if ActiveRecord::Type::Boolean.new.cast(sub_error)
        assert_includes error_messages(validator).keys, key
        assert_includes error_messages(validator)[key], 'must be filled'
      else
        assert_includes validator.errors.messages.keys, key
        assert_includes validator.errors[key], 'must be filled'
      end
    end

    def str?(validator, key, sub_error: false)
      if ActiveRecord::Type::Boolean.new.cast(sub_error)
        assert_includes error_messages(validator).keys, key
        assert_includes error_messages(validator)[key], 'must be a string'
      else
        assert_includes validator.errors.messages.keys, key
        assert_includes validator.errors[key], 'must be a string'
      end
    end

    def max_size?(validator, key, max_size, sub_error: false)
      if ActiveRecord::Type::Boolean.new.cast(sub_error)
        assert_includes error_messages(validator).keys, key
        assert_includes error_messages(validator)[key], "can't be longer than #{max_size} characters"
      else
        assert_includes validator.errors.messages.keys, key
        assert_includes validator.errors[key], "can't be longer than #{max_size} characters"
      end
    end

    def min_size?(validator, key, min_size, sub_error: false)
      if ActiveRecord::Type::Boolean.new.cast(sub_error)
        assert_includes error_messages(validator).keys, key
        assert_includes error_messages(validator)[key], "size cannot be less than #{min_size}"
      else
        assert_includes validator.errors.messages.keys, key
        assert_includes validator.errors[key], "size cannot be less than #{min_size}"
      end
    end

    def eql?(validator, key, eql, sub_error: false)
      if ActiveRecord::Type::Boolean.new.cast(sub_error)
        assert_includes error_messages(validator).keys, key
        assert_includes error_messages(validator)[key], "must be equal to #{eql}"
      else
        assert_includes validator.errors.messages.keys, key
        assert_includes validator.errors[key], "must be equal to #{eql}"
      end
    end

    def included_in?(validator, key, values, sub_error: false)
      if ActiveRecord::Type::Boolean.new.cast(sub_error)
        assert_includes error_messages(validator).keys, key
        assert_includes error_messages(validator)[key], "must be one of: #{values.join(', ')}"
      else
        assert_includes validator.errors.messages.keys, key
        assert_includes validator.errors[key], "must be one of: #{values.join(', ')}"
      end
    end

    def decimal?(validator, key, sub_error: false)
      if ActiveRecord::Type::Boolean.new.cast(sub_error)
        assert_includes error_messages(validator).keys, key
        assert_includes error_messages(validator)[key], 'must be a decimal'
      else
        assert_includes validator.errors.messages.keys, key
        assert_includes validator.errors[key], 'must be a decimal'
      end
    end

    def int?(validator, key, sub_error: false)
      if ActiveRecord::Type::Boolean.new.cast(sub_error)
        assert_includes error_messages(validator).keys, key
        assert_includes error_messages(validator)[key], 'must be an integer'
      else
        assert_includes validator.errors.messages.keys, key
        assert_includes validator.errors[key], 'must be an integer'
      end
    end

    def filled_optional?(validator, key, sub_error: false)
      if ActiveRecord::Type::Boolean.new.cast(sub_error)
        assert_includes error_messages(validator).keys, key
      else
        assert_not_includes validator.errors.messages.keys, key
      end
    end

    def size?(validator, key, size, sub_error: false)
      if ActiveRecord::Type::Boolean.new.cast(sub_error)
        assert_includes error_messages(validator).keys, key
        assert_includes error_messages(validator)[key], "Must be #{size} digits"
      else
        assert_includes validator.errors.messages.keys, key
        assert_includes validator.errors[key], "Must be #{size} digits"
      end
    end

    def format?(validator, key, sub_error: false)
      if ActiveRecord::Type::Boolean.new.cast(sub_error)
        assert_includes error_messages(validator).keys, key
        assert_includes error_messages(validator)[key], 'is in invalid format'
      else
        assert_includes validator.errors.messages.keys, key
        assert_includes validator.errors[key], 'is in invalid format'
      end
    end

    def gteq?(validator, key, num, sub_error: false)
      if ActiveRecord::Type::Boolean.new.cast(sub_error)
        assert_includes error_messages(validator).keys, key
        assert_includes error_messages(validator)[key], "must be greater than or equal to #{num}"
      else
        assert_includes validator.errors.messages.keys, key
        assert_includes validator.errors[key], "must be greater than or equal to #{num}"
      end
    end

    def gt?(validator, key, num, sub_error: false)
      if ActiveRecord::Type::Boolean.new.cast(sub_error)
        assert_includes error_messages(validator).keys, key
        assert_includes error_messages(validator)[key], "must be smaller than or equal to #{num}"
      else
        assert_includes validator.errors.messages.keys, key
        assert_includes validator.errors[key], "must be smaller than or equal to #{num}"
      end
    end

    def date_time?(validator, key, sub_error: false)
      if ActiveRecord::Type::Boolean.new.cast(sub_error)
        assert_includes error_messages(validator).keys, key
        assert_includes error_messages(validator)[key], 'must be a date/time'
      else
        assert_includes validator.errors.messages.keys, key
        assert_includes validator.errors[key], 'must be a date/time'
      end
    end

    def time?(validator, key, sub_error: false)
      if ActiveRecord::Type::Boolean.new.cast(sub_error)
        assert_includes error_messages(validator).keys, key
        assert_includes error_messages(validator)[key], 'must be time'
      else
        assert_includes validator.errors.messages.keys, key
        assert_includes validator.errors[key], 'must be time'
      end
    end

    def invalid?(validator, key, sub_error: false)
      if ActiveRecord::Type::Boolean.new.cast(sub_error)
        assert_includes error_messages(validator).keys, key
        assert_includes error_messages(validator)[key], 'invalid'
      else
        assert_includes validator.errors.messages.keys, key
        assert_includes validator.errors[key], 'invalid'
      end
    end

    def invalid_with?(validator, key, message, sub_error: false)
      if ActiveRecord::Type::Boolean.new.cast(sub_error)
        assert_includes error_messages(validator).keys, key
        assert_includes error_messages(validator)[key], message
      else
        assert_includes validator.errors.messages.keys, key
        assert_includes validator.errors[key], message
      end
    end

    def array?(validator, key, sub_error: false)
      if ActiveRecord::Type::Boolean.new.cast(sub_error)
        assert_includes error_messages(validator).keys, key
        assert_includes error_messages(validator)[key], 'must be an array'
      else
        assert_includes validator.errors.messages.keys, key
        assert_includes validator.errors[key], 'must be an array'
      end
    end

    private

    def error_messages(validator)
      errors = {}

      validator.to_result.failure?&.errors&.each do |error|
        next if error.text.blank?

        error_key = error.path.reverse.map(&:to_s).join('_of_').to_sym
        errors[error_key] = errors.fetch(error_key, []) << error.text
      end

      errors
    end
  end
end
# rubocop:enable Metrics/ModuleLength
