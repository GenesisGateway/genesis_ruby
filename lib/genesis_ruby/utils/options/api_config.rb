require 'genesis_ruby/utils/options/base'

module GenesisRuby
  module Utils
    module Options
      # Configurable Options used for the API Request configuration
      class ApiConfig < Base

        # Load pre-defined XML configuration
        def load_xml_config
          self.protocol = GenesisRuby::Api::Request::PROTOCOL_HTTPS
          self.port     = GenesisRuby::Api::Request::PORT_HTTPS
          self.type     = GenesisRuby::Api::Request::METHOD_POST
          self.format   = 'xml' # TODO: use the builder constant
        end

        # Load pre-defined JSON configuration
        def load_json_config
          self.protocol = GenesisRuby::Api::Request::PROTOCOL_HTTPS
          self.port     = GenesisRuby::Api::Request::PORT_HTTPS
          self.type     = GenesisRuby::Api::Request::METHOD_POST
          self.format   = 'json' # TODO: use the builder constant
        end

        # Load pre-defined FORM configuration
        def load_form_config
          self.protocol = GenesisRuby::Api::Request::PROTOCOL_HTTPS
          self.port     = GenesisRuby::Api::Request::PORT_HTTPS
          self.type     = GenesisRuby::Api::Request::METHOD_POST
          self.format   = 'form' # TODO: use the builder constant
        end

      end
    end
  end
end
