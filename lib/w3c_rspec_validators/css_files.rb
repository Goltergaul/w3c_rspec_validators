module W3cRspecValidators
  class CssFiles
    def self.compiled paths=["#{Rails.root}/public/assets/*.css"]
      system "rake assets:precompile"
      files = Dir.glob(paths.join(","))
      css = ""
      files.each do |f|
        css += File.read f
      end
      system "rake assets:clean"

      css
    end
  end
end
