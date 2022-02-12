# frozen_string_literal: true

class ServiceGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)

  check_class_collision suffix: "Service"

  def create_service_file
    %w[create update destroy list].each do |action|
      template(
        "#{action}.html.erb",
        File.join("app/services/#{create_service_name}_service", create_file_path, "#{action}.rb")
      )
    end
  end

  private

  def create_file_path
    path = class_name.split("::")
    path.shift
    path.join("/").underscore
  end

  def create_service_name
    (class_path.size.zero? ? file_path : class_path.first).singularize
  end
end
