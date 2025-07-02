# frozen_string_literal: true

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
          self.authorization         = GenesisRuby::Api::Request::AUTH_TYPE_BASIC
          self.bearer_token          = nil
        end

        # Load pre-defined JSON configuration
        def load_json_config
          self.protocol              = GenesisRuby::Api::Request::PROTOCOL_HTTPS
          self.port                  = GenesisRuby::Api::Request::PORT_HTTPS
          self.type                  = GenesisRuby::Api::Request::METHOD_POST
          self.format                = Builder::JSON
          self.parser_skip_root_node = false
          self.authorization         = GenesisRuby::Api::Request::AUTH_TYPE_BASIC
          self.bearer_token          = nil
        end

        # Load pre-defined FORM configuration
        def load_form_config
          self.protocol              = GenesisRuby::Api::Request::PROTOCOL_HTTPS
          self.port                  = GenesisRuby::Api::Request::PORT_HTTPS
          self.type                  = GenesisRuby::Api::Request::METHOD_POST
          self.format                = Builder::FORM
          self.parser_skip_root_node = true
          self.authorization         = GenesisRuby::Api::Request::AUTH_TYPE_BASIC
          self.bearer_token          = nil
        end

        # Load pre-defined GET configuration
        def load_get_config
          self.protocol              = GenesisRuby::Api::Request::PROTOCOL_HTTPS
          self.port                  = GenesisRuby::Api::Request::PORT_HTTPS
          self.type                  = GenesisRuby::Api::Request::METHOD_GET
          self.format                = Builder::XML
          self.parser_skip_root_node = false
          self.authorization         = GenesisRuby::Api::Request::AUTH_TYPE_BASIC
          self.bearer_token          = nil
        end

        # Load pre-defined GraphQL configuration
        def load_graphql_config
          self.protocol              = GenesisRuby::Api::Request::PROTOCOL_HTTPS
          self.port                  = GenesisRuby::Api::Request::PORT_HTTPS
          self.type                  = GenesisRuby::Api::Request::METHOD_POST
          self.format                = Builder::GRAPHQL
          self.parser_skip_root_node = false
          self.authorization         = GenesisRuby::Api::Request::AUTH_TYPE_TOKEN
          self.bearer_token          = nil
        end

      end
    end
  end
end
