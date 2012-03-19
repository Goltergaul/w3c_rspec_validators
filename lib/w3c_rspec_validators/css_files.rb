module W3cRspecValidators
  class CssFiles
    def self.compiled paths=["#{Rails.root}/public/assets/*.css"]
      system "rake -q assets:precompile"
      files = Dir.glob(paths.join(","))
      css = ""
      files.each do |f|
        css += File.read f
      end
      FileUtils.rm_rf "#{Rails.root}/public/assets/"

      css
    end
  end
end
