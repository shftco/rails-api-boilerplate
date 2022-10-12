# frozen_string_literal: true

module Supports
  module ApplicationService
    module Helper
      def resource_failure(resource)
        custom_resource_failure(resource.errors.full_messages)
      end

      def custom_resource_failure(errors)
        Failure({ errors: })
      end

      def create_resource(klass)
        record = klass.new(params)

        return Success(record) if record.save

        resource_failure(record)
      end

      def update_resource(record)
        return Success(record) if record.update(params)

        resource_failure(resource)
      end

      def destroy_resource(record)
        return Success(record) if record.destroy

        resource_failure(resource)
      end

      def find_resource(klass:, error_message: nil, **args)
        record = klass.find_by(args)

        return Success(record) if record.present?

        message = error_message || I18n.t('application_service.default.find_resource.error', klass: klass.to_s)

        custom_resource_failure([message])
      end
    end
  end
end
