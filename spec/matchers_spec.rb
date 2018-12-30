require "w3c_rspec_validators"
include W3CValidators

module RSpec
  module Matchers
    def fail
      raise_error(RSpec::Expectations::ExpectationNotMetError)
    end

    def fail_with(message)
      raise_error(RSpec::Expectations::ExpectationNotMetError, message)
    end

    def fail_matching(regex)
      raise_error(RSpec::Expectations::ExpectationNotMetError, regex)
    end
  end
end

describe "rspec matchers" do

  describe "be_valid_html" do
    it "should be valid" do
      body = <<~HTML
        <!DOCTYPE HTML>
        <html>
          <head>
            <title>dd</title>
          </head>
          <body>
          </body>
        </html>
      HTML

      expect(body).to be_valid_html
    end

    it "should not be valid" do
      body = <<~HTML
        <!DOCTYPE HTML>
        <html>
          <head>
            <titled>dd</title>
          </head>
          <body></body>
        </html>
      HTML

      expect(body).to_not be_valid_html
    end

    it "should complain about an missing src attribute" do
      body = <<~HTML
        <!DOCTYPE HTML>
        <html>
          <head>
            <title>dd</title>
          </head>
          <body>
            <img />
          </body>
        </html>
      HTML

      expect {
        expect(body).to be_valid_html
      }.to fail_matching(/line 7: Element “img” is missing required attr/m)
    end

    it "should use a custom uri if provided" do
      allow(W3cRspecValidators::Config).to receive(:get).and_return("w3c_service_uri" => "https://validator.nu/")

      expect(NuValidator).to receive(:new).with(validator_uri: "https://validator.nu/").and_call_original

      expect("dummy").to_not be_valid_html
    end
  end

  describe "be_valid_css" do
    it "should be valid" do
      expect("body {}").to be_valid_css
    end

    it "should not be valid" do
      expect("body { foo: 12px; }").to_not be_valid_css
    end

    it "should not be valid" do
      expect {
        expect("body { foo: 12px; }").to be_valid_css
      }.to fail_matching(/Property “foo” doesn't exist/)
    end
  end
end
