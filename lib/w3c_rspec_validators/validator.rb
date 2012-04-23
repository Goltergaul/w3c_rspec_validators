module W3cRspecValidators
  class Validator
    attr_reader :response
    include W3CValidators

    def initialize
      @html_validator = MarkupValidator.new validator_uri: Config.get["w3c_service_uri"]
      @css_validator = CSSValidator.new validator_uri: Config.get["w3c_css_service_uri"]
    end

    def try method, try_count = 1
      begin
        method.call
      rescue Exception => e
        raise e if try_count >= 3
        sleep 3
        try(method, try_count + 1)
      end
    end

    def validate_html text
      validate = Proc.new {
        @response = @html_validator.validate_text(text)
      }
      try validate
      raise "Error: Invalid validation response! Tip: check if validator.nu engine is configured correctly" if @response.checked_by.blank?
      @response
    end

    def validate_css text
      validate = Proc.new {
        @response = @css_validator.validate_text(text)
      }
      try validate
      raise "Error: Invalid validation response! Tip: check if validator.nu engine is configured correctly" if @response.checked_by.blank?
      @response
    end
  end

end
