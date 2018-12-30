require "rails"

module W3cRspecValidators

  class Railtie < Rails::Railtie
    initializer "initialize config" do
      config_file = Rails.root.join("config", "w3c_rspec_validators.yml")
      if config_file.file? &&
        Config.load!(config_file)
      end

     # puts ActionDispatch::Routing::UrlFor::url_for("/")
    end
  end

  class Config
    @@config = {
      validator_uri: ""
    }

    def self.load! config_file
      @@config = YAML.load(File.open(config_file))["config"]
    end

    def self.get
      @@config
    end
  end

end
