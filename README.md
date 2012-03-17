# W3C rspec validations

This gem adds rspec matchers that allow you to check if the html code produced by your rails app is valid.

## Install

You need rspec for this gem to work. In addition add this to your gemfile:

    gem "w3c_rspec_validators"

## Usage

Here is an example for using it in an acceptance test:

```ruby
scenario "visit landing page" do
  visit "/"
  page.body.should be_valid_html
end
```

If you use capybara with a headless driver or something similiar be 
sure to check the original source code to be valid and not the source code that has
been parsed and eventually corrected by the browser:

```ruby
scenario "visit landing page" do
  visit "/"
  page.driver.source.should be_valid_html
end
```

If you want to check html code, that has been modified by javascript, use "page.body.should be_valid_html".
Note that a browser may correct wrongly nested tags on its own.

## Running faster offline validation

If you do not want to use the online W3C Validation service, which is default, you can set the validator url to anything yo want:

    W3cRspecValidators::HTML5Validator.validator_uri = "http://localhost/check"

Check this url to see how to install your local version of the W3C validation service: http://validator.w3.org/docs/install.html
For local HTML5 validation to work you'll need validator.nu running locally too: http://about.validator.nu/
