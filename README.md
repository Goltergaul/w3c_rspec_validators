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
  page.driver.source.should be_valid_html5
end
```
