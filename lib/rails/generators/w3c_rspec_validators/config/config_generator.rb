module W3cRspecValidators
  module Generators
    class ConfigGenerator < Rails::Generators::Base
      desc 'Creates a w3c_rspec_validators gem configuration file at config/w3c_rspec_validators.yml'

      def self.source_root
        @_source_root ||= File.expand_path("../templates", __FILE__)
      end

      def create_config_file
        template 'w3c_rspec_validators.yml', File.join('config', 'w3c_rspec_validators.yml')
      end
    end
  end
end
