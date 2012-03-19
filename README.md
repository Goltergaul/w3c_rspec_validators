# W3C rspec validations

This gem adds rspec matchers that allow you to check if the html code produced by your rails app is valid.

## Install

You need rspec for this gem to work. In addition add this to your gemfile:

    gem "w3c_rspec_validators"

## Usage

Here are examples for using it in acceptance tests:

### HTML Validation

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

### CSS Validation

W3cRspecValidators::CssFiles.compiled will run rake assets:precompile and returns
the applications css as string.

WARNING: This also deletes the folder public/assets so that the compiled assets are removed after the tests.

```ruby
it "should be valid css" do
  W3cRspecValidators::CssFiles.compiled.should be_valid_css
end
```


## Running faster offline validation

If you do not want to use the online W3C Validation service, which is default, you can set the validator url to a locally runnig version
of the W3C Validator service by creating a config file:

    rails g w3c_rspec_validators:config

Check this url to see how to install your local version of the W3C validation service: http://validator.w3.org/docs/install.html
For local HTML5 validation to work you'll need validator.nu running locally too: http://about.validator.nu

For local CSS validation to work you'll need http://jigsaw.w3.org/css-validator/DOWNLOAD.html

## Licence
MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
