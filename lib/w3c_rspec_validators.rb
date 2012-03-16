require "w3c_rspec_validators/version"
require "w3c_validators"

module W3cRspecValidators
  include W3CValidators

  class HTML5Validator
    def self.validator_uri
      @@validator_uri
    end

    def self.validator_uri= value
      @@validator_uri = value
    end

    self.validator_uri = "http://validator.w3.org/check"
  end  
end

require "w3c_rspec_validators/rspec"
