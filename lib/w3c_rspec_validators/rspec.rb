module W3cRspecValidators

  RSpec::Matchers.define :be_valid_html do
    validator = Validator.new
    match do |body|
      validator.validate_html(body)
      validator.response.errors.length == 0
    end
    failure_message do |actual|
      validator.response.errors.map do |err|
        ErrorParser.parse_html_error(err, actual)
      end.join("\n")
    end
  end

  RSpec::Matchers.define :be_valid_css do
    validator = Validator.new
    match do |css|
      validator.validate_css css
      validator.response.errors.length == 0
    end

    failure_message do |actual|
      validator.response.errors.map do |err|
        ErrorParser.parse_css_error(err, actual)
      end.join("\n")
    end
  end
end
