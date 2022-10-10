# frozen_string_literal: true

class ServiceGenerator < Rails::Generators::NamedBase
  argument :params, type: :array, default: [], banner: 'action action'
  class_option :parent, type: :string, default: 'ApplicationService', desc: 'The parent class for the generated service'

  check_class_collision suffix: 'Service'

  source_root File.expand_path('templates', __dir__)

  def create_service_files
    template 'service.rb', File.join('app/services/', class_path, "#{file_name}_service.rb")
    template 'service_test.rb', File.join('test/services/', class_path, "#{file_name}_service_test.rb")

    return unless Rails.env.development?

    system("rubocop -A #{service_file_path}")
    system("rubocop -A #{service_test_file_path}")
  end

  private

  def service_file_path
    "app/services/#{class_path.join('/')}/#{file_name}_service.rb"
  end

  def service_test_file_path
    "test/services/#{class_path.join('/')}/#{file_name}_service_test.rb"
  end

  def parent_class_name
    options[:parent]
  end

  def file_name
    @_file_name ||= remove_possible_suffix(super)
  end

  def remove_possible_suffix(name)
    name.sub(/_?service$/i, '')
  end
end
