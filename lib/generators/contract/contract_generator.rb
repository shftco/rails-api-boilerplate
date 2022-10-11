# frozen_string_literal: true

class ContractGenerator < Rails::Generators::NamedBase
  argument :params, type: :array, default: [], banner: 'name:o fullname:required'
  class_option :parent, type: :string, default: 'ApplicationContract', desc: 'The parent class for the generated contract'

  check_class_collision suffix: 'Contract'

  source_root File.expand_path('templates', __dir__)

  def create_contract_files
    template 'contract.rb', File.join('app/contracts/', class_path, "#{file_name}_contract.rb")
    template 'contract_test.rb', File.join('test/contracts/', class_path, "#{file_name}_contract_test.rb")

    return unless Rails.env.development?

    system("rubocop -A #{contract_file_path}")
    system("rubocop -A #{contract_test_file_path}")
  end

  private

  def contract_file_path
    "app/contracts/#{class_path.join('/')}/#{file_name}_contract.rb"
  end

  def contract_test_file_path
    "test/contracts/#{class_path.join('/')}/#{file_name}_contract_test.rb"
  end

  def parent_class_name
    options[:parent]
  end

  def formatted_params
    params.map do |current_param|
      type = type_defined_for_param?(current_param) ? defined_type_for_param(current_param) : 'optional'

      [type, parse_param(current_param).first]
    end
  end

  def parse_param(current_param)
    current_param.split(':')
  end

  def type_defined_for_param?(current_param)
    param = parse_param(current_param)

    return false if param.size <= 1

    valid_types = %w[r o required optional]

    valid_types.include?(param.second)
  end

  def defined_type_for_param(current_param)
    param = parse_param(current_param)

    case param.last
    when 'o', 'optional'
      'optional'
    when 'r', 'required'
      'required'
    end
  end

  def file_name
    @_file_name ||= remove_possible_suffix(super)
  end

  def remove_possible_suffix(name)
    name.sub(/_?contract$/i, '')
  end
end
