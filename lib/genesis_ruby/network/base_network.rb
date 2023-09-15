require 'genesis_ruby/errors/invalid_argument_error'
require 'genesis_ruby/utils/options/network_adapter_config'
require 'base64'

module GenesisRuby
  module Network
    # Base Network factory class
    class BaseNetwork

      XML_HEADER  = 'application/xml'.freeze
      JSON_HEADER = 'application/json'.freeze

      # Base constructor
      def initialize(configuration)
        @context                = factory
        @configuration          = configuration
        @network_adapter_config = GenesisRuby::Utils::Options::NetworkAdapterConfig.new
      end

      # Return the Response Body
      def response_body
        @context.response_body
      end

      # Return the Response Headers
      def response_headers
        @context.response_headers
      end

      # Send the request
      def send_request
        @context.execute
      end

      # Initialize the Adapter
      def init_api_data(request)
        @context.prepare_request(adapter_data_mapper(request))
      end

      # Every child defines is XML Response Type
      def xml?
        raise NotImplementedError, 'Is XML method must be implemented'
      end

      # Every child defines is JSON Response Type
      def json?
        raise NotImplementedError, 'Is JSON method must be implemented'
      end

      protected

      # GenesisRuby::Configuration, Adapter Context, Network Adapter Config mapper
      attr_reader :configuration, :context, :network_adapter_config

      # Every child override and initialize its instance
      def factory
        raise NotImplementedError, 'Factory method must be implemented'
      end

      # Map the Request to the Network Adapter object
      def adapter_data_mapper(request)
        network_adapter_config.map_from_request(request).merge(
          {
            user_login: build_user_login,
            user_agent: network_user_agent,
            timeout:    configuration.timeout
          }
        )
      end

      # Build the User login string used for the Authorization Header
      def build_user_login
        Base64.urlsafe_encode64("#{configuration.username}:#{configuration.password}")
      end

      # The default user agent for every Network
      def network_user_agent
        "Genesis Ruby Client #{GenesisRuby::VERSION}. Network: #{self.class.name}"
      end

    end
  end
end
