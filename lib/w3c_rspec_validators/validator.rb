module W3cRspecValidators
  class Validator
    attr_reader :response
    include W3CValidators

    def initialize
      @html_validator = MarkupValidator.new validator_uri: Config.get["w3c_service_uri"]
      @css_validator = CSSValidator.new validator_uri: Config.get["w3c_css_service_uri"]
    end

    def validate_html text
      @response = @html_validator.validate_text(text)
      raise "Error: Invalid validation response! Tip: check if validator.nu engine is configured correctly" if @response.checked_by.blank?
      @response
    end

    def validate_css text
      @response = @css_validator.validate_text(text)
      raise "Error: Invalid validation response! Tip: check if validator.nu engine is configured correctly" if @response.checked_by.blank?
      @response
    end
  end

end
