# frozen_string_literal: true

module Helpers
  module FormValidator
    def success?(validator, key)
      assert_not_includes validator.errors.messages.keys, key
    end

    def filled?(validator, key)
      assert_includes validator.errors.messages.keys, key
      assert_includes validator.errors[key], 'must be filled'
    end

    def str?(validator, key)
      assert_includes validator.errors.messages.keys, key
      assert_includes validator.errors[key], 'must be a string'
    end

    def max_size?(validator, key, max_size)
      assert_includes validator.errors.messages.keys, key
      assert_includes validator.errors[key], "can't be longer than #{max_size} characters"
    end

    def min_size?(validator, key, min_size)
      assert_includes validator.errors.messages.keys, key
      assert_includes validator.errors[key], "size cannot be less than #{min_size}"
    end

    def eql?(validator, key, eql)
      assert_includes validator.errors.messages.keys, key
      assert_includes validator.errors[key], "must be equal to #{eql}"
    end

    def included_in?(validator, key, values)
      assert_includes validator.errors.messages.keys, key
      assert_includes validator.errors[key], "must be one of: #{values.join(', ')}"
    end

    def decimal?(validator, key)
      assert_includes validator.errors.messages.keys, key
      assert_includes validator.errors[key], 'must be a decimal'
    end

    def int?(validator, key)
      assert_includes validator.errors.messages.keys, key
      assert_includes validator.errors[key], 'must be an integer'
    end

    def filled_optional?(validator, key)
      assert_not_includes validator.errors.messages.keys, key
    end

    def size?(validator, key, size)
      assert_includes validator.errors.messages.keys, key
      assert_includes validator.errors[key], "Must be #{size} digits"
    end

    def format?(validator, key)
      assert_includes validator.errors.messages.keys, key
      assert_includes validator.errors[key], 'is in invalid format'
    end

    def gteq?(validator, key, num)
      assert_includes validator.errors.messages.keys, key
      assert_includes validator.errors[key], "must be greater than or equal to #{num}"
    end

    def gt?(validator, key, num)
      assert_includes validator.errors.messages.keys, key
      assert_includes validator.errors[key], "must be smaller than or equal to #{num}"
    end

    def date_time?(validator, key)
      assert_includes validator.errors.messages.keys, key
      assert_includes validator.errors[key], 'must be a date/time'
    end

    def time?(validator, key)
      assert_includes validator.errors.messages.keys, key
      assert_includes validator.errors[key], 'must be time'
    end

    def invalid?(validator, key)
      assert_includes validator.errors.messages.keys, key
      assert_includes validator.errors[key], 'invalid'
    end
  end
end
