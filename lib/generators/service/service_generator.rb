# frozen_string_literal: true

class ServiceGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)

  check_class_collision suffix: "Service"

  def create_service_file
    %w[create update destroy list].each do |action|
      template(
        "#{action}.html.erb",
        File.join("app/services/#{create_service_file_name}_service", create_file_path, "#{action}.rb")
      )
    end
  end

  private

  def service_classes
    class_name.split("::")
  end

  def create_file_path
    path = service_classes
    path.shift
    path.join("/").underscore
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
      class_names.join("::")
    end
  end
end
