# frozen_string_literal: true

require 'genesis_ruby/errors/response_error'
require 'genesis_ruby/parser'
require 'genesis_ruby/api/constants/states'
require 'genesis_ruby/api/constants/states/state'
require 'genesis_ruby/utils/object_formatter'
require 'genesis_ruby/utils/formatters/response/loader'

module GenesisRuby
  module Api
    # Response - process/format an incoming Genesis response
    class Response

      def initialize(configuration, request_api_config = {})
        @configuration      = configuration
        @object_formatter   = GenesisRuby::Utils::ObjectFormatter.new
        @response_formatter = GenesisRuby::Utils::Formatters::Response::Loader.new
        @request_api_config = request_api_config
      end

      # Default Response Object initialization
      def response_object
        @response_object ||= {}
      end

      # Default Response Raw initialization
      def response_raw
        @response_raw ||= ''
      end

      # Parse the response from the given Network
      def parse_response(network)
        @network_context = network
        @response_raw    = @network_context.response_body
        @response_object = load_parser(@network_context).parse_document(@response_raw)

        process_response_object
      end

      # Dynamic Helper Methods
      def method_missing(symbol)
        super unless GenesisRuby::Api::Constants::States::State.handle_respond_to_states(symbol)

        handle_method_missing_states(symbol)
      end

      # Respond to missing implementation
      def respond_to_missing?(symbol, include_private = false)
        GenesisRuby::Api::Constants::States::State.handle_respond_to_states(symbol) || super
      end

      protected

      attr_reader :network_context, :parser, :configuration, :object_formatter, :response_formatter

      # Load the corresponding parser based on the Network header
      def load_parser(network)
        @parser = GenesisRuby::Parser.new(GenesisRuby::Parser::JSON) if network.json?
        @parser = GenesisRuby::Parser.new(GenesisRuby::Parser::XML) if network.xml?

        raise NetworkError, network.server_message if @parser.nil? || @response_raw.empty?

        @parser.skip_root_node if @request_api_config[:parser_skip_root_node]

        @parser
      end

      # Add dynamic Sate handling
      def handle_method_missing_states(symbol)
        method = symbol.to_s.downcase

        state = GenesisRuby::Api::Constants::States::State.new(response_object[:status])

        return state.public_send(method) if state.respond_to?(method)

        false
      end

      # Format the Response object
      def process_response_object
        GenesisRuby::Utils::Common.deep_compact_empty!(@response_object) if configuration.sanitize_response

        if configuration.format_response
          object_formatter.formats = @response_formatter.formats
          @response_object = object_formatter.format_structure(@response_object)
        end

        @response_object
      end

    end
  end
end
