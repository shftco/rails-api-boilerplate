# frozen_string_literal: true

class OperationGenerator < Rails::Generators::NamedBase
  argument :params, type: :array, default: [], banner: 'action action'
  class_option :parent, type: :string, default: 'ApplicationOperation', desc: 'The parent class for the generated operation'

  check_class_collision suffix: 'Operation'

  source_root File.expand_path('templates', __dir__)

  def create_operation_files
    template 'operation.rb', File.join('app/operations/', class_path, "#{file_name}_operation.rb")
    template 'operation_test.rb', File.join('test/operations/', class_path, "#{file_name}_operation_test.rb")

    return unless Rails.env.development?

    system("rubocop -A #{operation_file_path}")
    system("rubocop -A #{operation_test_file_path}")
  end

  private

  def operation_file_path
    "app/operations/#{class_path.join('/')}/#{file_name}_operation.rb"
  end

  def operation_test_file_path
    "test/operations/#{class_path.join('/')}/#{file_name}_operation_test.rb"
  end

  def parent_class_name
    options[:parent]
  end

  def file_name
    @_file_name ||= remove_possible_suffix(super)
  end

  def remove_possible_suffix(name)
    name.sub(/_?operation$/i, '')
  end
end
