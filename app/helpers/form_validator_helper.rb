# frozen_string_literal: true

module FormValidatorHelper
  def form_errors_to_json(form)
    errors = []

    form.to_result.failure?&.errors&.each do |error|
      next if error.text.blank?

      humanized_error_text = error_text(error, form)

      next if errors.include?(humanized_error_text)

      errors.push(humanized_error_text)
    end

    errors
  end

  private

  def error_text(error, form)
    error_path = error_path_parser(error)
    humanized_error_path = humanized_error_path_parser(error_path, form)

    "#{humanized_error_path} #{error.text}"
  end

  def error_path_parser(error)
    case I18n.locale
    when :en
      error.path.reverse.map(&:to_s)
    when :tr
      error.path.map(&:to_s)
    else
      raise "Unsupported locale #{I18n.locale}"
    end
  end

  def humanized_error_path_parser(error_path, form)
    case I18n.locale
    when :en
      error_path.map(&:humanize).join(" #{error_text_splitter} ").capitalize
    when :tr
      error_path.map do |path|
        I18n.t("forms.#{form.class.to_s.underscore}.attributes.#{path}").to_s
      end.join(" #{error_text_splitter} ").capitalize
    else
      raise "Unsupported locale #{I18n.locale}"
    end
  end

  def error_text_splitter
    case I18n.locale
    when :en
      'of'
    when :tr
      'içindeki'
    else
      raise "Unsupported locale #{I18n.locale}"
    end
  end
end
