# frozen_string_literal: true

class FormGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)

  check_class_collision suffix: "Form"

  def create_service_file
    template(
      "form.html.erb",
      File.join("app/forms/#{create_form_file_name}_form", create_file_path, "create.rb")
    )
  end

  private

  def form_classes
    class_name.split("::")
  end

  def create_file_path
    path = form_classes
    path.shift
    path.join("/").underscore
  end

  def create_form_file_name
    (class_path.size.zero? ? file_path : class_path.first).singularize
  end

  def form_class_name
    if form_classes.size == 1
      "#{class_name.singularize.camelize}Form"
    else
      class_names = form_classes
      class_names[0] = "#{class_names.first.singularize.camelize}Form"
      class_names.join("::")
    end
  end
end
