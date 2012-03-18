module W3cRspecValidators
  
  RSpec::Matchers.define :be_valid_html do
    validator = Validator.new
    match do |body|
      validator.validate_text(body)
      validator.response.errors.length == 0
    end
    failure_message_for_should do |actual|
      validator.response.errors.map do |err|
        seperator = "######\n"
        error = /line \d.*/.match err.to_s
        line_number = /line (\d*)/.match(err.to_s)[1].to_i

        sbody = actual.split("\n")
        context = sbody[[line_number-3,0].max...line_number-1].join("\n")
        context += "\n>>" + sbody[line_number-1] + "\n"
        context += sbody[line_number..line_number+2].join("\n")

        seperator + error.to_s + "\n\n" + context + "\n"
      end.join("\n")
    end
  end

end
