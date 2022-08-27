# frozen_string_literal: true

class ContractGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  check_class_collision suffix: 'Contract'

  def create_contract_files
    template(
      'contract.html.erb',
      File.join("app/contracts/#{create_contract_file_name}#{create_file_path}.rb")
    )

    # test
    template(
      'contract_test.html.erb',
      File.join("test/contracts/#{create_contract_file_name}#{create_file_path}_test.rb")
    )
  end

  private

  def contract_classes
    class_name.split('::')
  end

  def create_file_path
    path = contract_classes
    path.shift
    path = path.join('/').underscore
    path.empty? ? '' : "/#{path}_contract"
  end

  def create_contract_file_name
    (class_path.size.zero? ? file_path : class_path.first).pluralize
  end

  def contract_class_name
    if contract_classes.size == 1
      class_name.pluralize.camelize.to_s
    else
      class_names = contract_classes
      class_names[0] = class_names.first.pluralize.camelize.to_s
      class_names.join('::')
    end
  end
end
