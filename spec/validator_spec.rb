require "w3c_rspec_validators"
include W3CValidators

describe W3cRspecValidators::Validator do

  describe "initialize" do
    it "should initialize MarkupValidator with config value" do
      W3cRspecValidators::Config.stub(:get).and_return("w3c_service_uri" => "http://blubb.de", "w3c_css_service_uri" => "http://test.de")
      MarkupValidator.should_receive(:new).with(validator_uri: "http://blubb.de")
      CSSValidator.should_receive(:new).with(validator_uri: "http://test.de")

      W3cRspecValidators::Validator.new
    end
  end

  describe "validate_text" do
    it "should raise an exception if validation fails silently" do
      class Dummy
        def checked_by
          ""
        end
      end
      MarkupValidator.any_instance.stub(:validate_text).and_return Dummy.new
      
      expect {
        W3cRspecValidators::Validator.new.validate_text("dummy")
      }.to raise_exception
    end
  end
end
