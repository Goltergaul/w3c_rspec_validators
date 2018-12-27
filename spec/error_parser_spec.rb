require "w3c_rspec_validators"

describe "error_parser" do

  describe "self.parse_css" do
    before(:each) do
      @css_error_message = "ERROR; URI: file://localhost/TextArea; line 7:

                                Property foo doesn't exist :"
      @css = "
body {
  blubb: 1 px;
}
/* line 5, ../../app/assets/stylesheets/home.css.scss */
#home {
  foo: 2px;
}"
    end

    it "should properly format css errors" do
      error = W3cRspecValidators::ErrorParser.parse_css_error(@css_error_message, @css)

      expect(error).to eq "######
Property foo doesn't exist :
Real code location(guessed) in File ../../app/assets/stylesheets/home.css.scss on line 2

Code context:
/* line 5, ../../app/assets/stylesheets/home.css.scss */
#home {
>>  foo: 2px;
}\n"
    end
  end

  describe "self.parse_html" do
    before(:each) do
      @html_error_message = "ERROR; URI: upload://Form Submission; line 7: An img element must have an alt attribute, except under certain conditions. For details, consult guidance on providing text alternatives for images."
      @html = "<!DOCTYPE HTML SYSTEM>
        <html>
          <head>
            <title>dd</title>
          </head>
          <body>
            <img />
          </body>
        </html>"
    end

    it "should properly format a html error message" do
      error = W3cRspecValidators::ErrorParser.parse_html_error(@html_error_message, @html)

      expect(error).to eq "######
line 7: An img element must have an alt attribute, except under certain conditions. For details, consult guidance on providing text alternatives for images.

          </head>
          <body>
>>            <img />
          </body>
        </html>\n"
    end
  end
end
