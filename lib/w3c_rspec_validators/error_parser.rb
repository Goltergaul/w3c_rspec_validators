module W3cRspecValidators
  class ErrorParser
    def self.parse_html_error err, actual
      seperator = "######\n"
      error = /line \d.*/.match err.to_s
      line_number = /line (\d*)/.match(err.to_s)[1].to_i

      sbody = actual.split("\n")
      context = sbody[[line_number-3,0].max...line_number-1].join("\n")
      context += "\n>>" + sbody[line_number-1] + "\n"
      context += sbody[line_number..line_number+2].join("\n")

      seperator + error.to_s + "\n\n" + context + "\n"
    end

    def self.parse_css_error err, actual
      seperator = "######\n"
      error = /line \d*:(.*)/m.match(err.to_s)[1]
      line_number = /line (\d*)/.match(err.to_s)[1].to_i

      stext = actual.split("\n")

      i = line_number
      file = ""
      while true do
        if i == 0 || match = /\/\* line \d*,(.*)\*\//.match(stext[i])
          unless match.nil?
            file = match[1].strip
          end
          break
        end
        i -= 1
      end
      real_line_number = line_number - i - 1

      context = stext[[line_number-3,0].max...line_number-1].join("\n")
      context += "\n>>" + stext[line_number-1] + "\n"
      context += stext[line_number..line_number+2].join("\n")

      seperator + error.to_s.gsub(/\n/,"").gsub("  ", "") + "\nReal code location(guessed) in File " + file + " on line #{real_line_number}\n\nCode context:\n" + context + "\n"
    end
  end
end
