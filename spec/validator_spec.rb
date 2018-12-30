require "w3c_rspec_validators"
include W3CValidators

describe W3cRspecValidators::Validator do

  describe "initialize" do
    it "should initialize MarkupValidator with config value" do
      allow(W3cRspecValidators::Config).to receive(:get).and_return("w3c_service_uri" => "http://blubb.de", "w3c_css_service_uri" => "http://test.de")
      expect(NuValidator).to receive(:new).with(validator_uri: "http://blubb.de")
      expect(CSSValidator).to receive(:new).with(validator_uri: "http://test.de")

      W3cRspecValidators::Validator.new
    end
  end

  describe "validate_text" do
    it "should raise an exception if validation fails silently (eg. validator.nu engine misconfiguration)" do
      class Dummy
        def checked_by
          ""
        end
      end

      allow_any_instance_of(NuValidator).to receive(:validate_text).and_return(Dummy.new)

      expect {
        W3cRspecValidators::Validator.new.validate_html("dummy")
      }.to raise_exception(W3cRspecValidators::Validator::Error)
    end
  end

  describe "error handling" do
    it "should retry 3 times if there is a connection error" do
      allow_any_instance_of(NuValidator).to receive(:validate_text).and_raise(StandardError)
      validator = W3cRspecValidators::Validator.new
      expect(validator).to receive(:sleep).exactly(2).times

      expect {
        validator.validate_html("dummy")
      }.to raise_exception(StandardError)
    end
  end
end
