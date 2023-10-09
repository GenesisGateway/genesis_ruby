require 'genesis_ruby/utils/options/base'

module GenesisRuby
  module Utils
    module Options
      # Configurable Options used for the API Request configuration
      class ApiConfig < Base

        # Load pre-defined XML configuration
        def load_xml_config
          self.protocol              = GenesisRuby::Api::Request::PROTOCOL_HTTPS
          self.port                  = GenesisRuby::Api::Request::PORT_HTTPS
          self.type                  = GenesisRuby::Api::Request::METHOD_POST
          self.format                = Builder::XML
          self.parser_skip_root_node = true
        end

        # Load pre-defined JSON configuration
        def load_json_config
          self.protocol              = GenesisRuby::Api::Request::PROTOCOL_HTTPS
          self.port                  = GenesisRuby::Api::Request::PORT_HTTPS
          self.type                  = GenesisRuby::Api::Request::METHOD_POST
          self.format                = Builder::JSON
          self.parser_skip_root_node = false
        end

        # Load pre-defined FORM configuration
        def load_form_config
          self.protocol              = GenesisRuby::Api::Request::PROTOCOL_HTTPS
          self.port                  = GenesisRuby::Api::Request::PORT_HTTPS
          self.type                  = GenesisRuby::Api::Request::METHOD_POST
          self.format                = Builder::FORM
          self.parser_skip_root_node = true
        end

      end
    end
  end
end
