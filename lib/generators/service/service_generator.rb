# frozen_string_literal: true

class ServiceGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  check_class_collision suffix: 'Service'

  class_option :actions, type: :array, default: [], banner: 'create update'

  ALLOWED_ACTIONS = %w[create update destroy list].freeze

  def create_service_file
    check_validity!
    options[:actions].size.zero? ? create_service_file_without_actions : create_service_file_with_actions
  end

  private

  def create_service_file_without_actions
    ALLOWED_ACTIONS.each do |action|
      create_template(action)
    end
  end

  def create_service_file_with_actions
    options[:actions].each do |action|
      create_template(action)
    end
  end

  def create_template(action)
    template(
      "#{action}.html.erb",
      File.join("app/services/#{create_service_file_name}_service", create_file_path, "#{action}.rb")
    )

    template(
      "#{action}_test.html.erb",
      File.join("test/services/#{create_service_file_name}_service", create_file_path, "#{action}_test.rb")
    )
  end

  def service_classes
    class_name.split('::')
  end

  def create_file_path
    path = service_classes
    path.shift
    path.join('/').underscore
  end

  def create_service_file_name
    (class_path.size.zero? ? file_path : class_path.first).singularize
  end

  def service_class_name
    if service_classes.size == 1
      "#{class_name.singularize.camelize}Service"
    else
      class_names = service_classes
      class_names[0] = "#{class_names.first.singularize.camelize}Service"
      class_names.join('::')
    end
  end

  def check_validity!
    raise "Invalid actions: #{options[:actions].join(', ')}" unless options[:actions].all? { |action| ALLOWED_ACTIONS.include?(action) }
  end
end
