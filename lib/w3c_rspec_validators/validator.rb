module W3cRspecValidators
  class Validator
    attr_reader :response
    include W3CValidators

    def initialize
      @validator = MarkupValidator.new validator_uri: Config.get["w3c_service_uri"]
    end

    def validate_text text
      @response = @validator.validate_text(text)
      raise "Error: Invalid validation response! Tip: check if validator.nu engine is configured correctly" if @response.checked_by.blank?
    end
  end
end
