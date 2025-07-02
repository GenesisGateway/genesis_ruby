# frozen_string_literal: true

require 'genesis_ruby/utils/options/network_adapter_config'

module GenesisRuby
  module Network
    # Base Network factory class
    class BaseNetwork

      XML_HEADER  = 'application/xml'
      JSON_HEADER = 'application/json'
      HTML_HEADER = 'text/html'

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

      # Whether returned response is an error response
      def error?
        @context.error?
      end

      # Returns the server message
      def server_message
        @context.server_message
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

      # Every child defines is HTML Response Type
      def html?
        raise NotImplementedError, 'Is HTML method must be implemented'
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
        network_adapter_config.map_from_request(request, configuration).merge({ user_agent: network_user_agent })
      end

      # The default user agent for every Network
      def network_user_agent
        "Genesis Ruby Client #{GenesisRuby::VERSION}. Network: #{self.class.name}"
      end

    end
  end
end
