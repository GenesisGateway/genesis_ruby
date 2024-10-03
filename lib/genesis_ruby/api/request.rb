require 'genesis_ruby/utils/options/api_config'
require 'genesis_ruby/errors/endpoint_not_set_error'
require 'genesis_ruby/builder'
require 'genesis_ruby/utils/common'
require 'genesis_ruby/utils/money_format'

module GenesisRuby
  module Api
    # Base Request Class
    class Request

      include Mixins::Requests::RestrictedSetter
      include Mixins::Requests::AttributeValidation

      PROTOCOL_HTTPS = 'https'.freeze
      PORT_HTTPS     = 443

      METHOD_POST    = 'POST'.freeze
      METHOD_GET     = 'GET'.freeze
      METHOD_PUT     = 'PUT'.freeze

      attr_reader :api_config

      def initialize(configuration, builder_interface = 'xml')
        @configuration     = configuration
        @builder_interface = builder_interface
        @api_config        = GenesisRuby::Utils::Options::ApiConfig.new

        init_configuration
        init_field_validations
      end

      # Generate the Request Document based on the builder_interface
      def build_document
        process_request_parameters

        if tree_structure.instance_of?(Hash)
          @builder_context = GenesisRuby::Builder.new(builder_interface)
          builder_context.parse_structure(tree_structure.clone)

          return builder_context.document
        end

        nil
      end

      protected

      attr_reader :configuration, :builder_interface, :builder_context
      attr_accessor :tree_structure

      # Required fields for the request
      def init_field_validations; end

      # Request Configuration
      def init_configuration; end

      # Pre-defined XML Request Configuration
      def init_xml_configuration
        @api_config.load_xml_config
      end

      # Pre-defined JSON Request Configuration
      def init_json_configuration
        @api_config.load_json_config
      end

      # Pre-defined FORM Request Configuration
      def init_form_configuration
        @api_config.load_form_config
      end

      # Initializes Api EndPoint Url with request path & terminal token
      def init_api_gateway_configuration(options = { request_path: 'process', include_token: true })
        request_path  = options.fetch :request_path, 'process'
        include_token = options.fetch :include_token, true

        api_config.url = build_request_url(
          {
            subdomain: 'gateway',
            path:      request_path,
            token:     include_token ? @configuration.token : ''
          }
        )
      end

      # Initializes WPF EndPoint Url with internationalization
      def init_api_wpf_configuration(options = { language: '' })
        language = (options.fetch :language, '').to_s

        api_config.url = build_request_url(
          {
            subdomain: 'wpf',
            path:      language.empty? ? 'wpf' : format('%{language}/wpf', { language: language })
          }
        )
      end

      # Process Everything the variables set previously
      #
      # Step 1: Execute per-field actions
      # Step 2: Update the Tree structure
      # Step 3: Clean the empty leafs
      # Step 4: Check for Required Fields
      def process_request_parameters
        populate_structure

        sanitize_structure

        check_requirements
      end

      # Create the Tree structure and populate
      # the fields with the set parameters.
      # Every request defines the :tree_structure
      def populate_structure
        @tree_structure = {}
      end

      # Remove empty key values from the structure
      def sanitize_structure
        GenesisRuby::Utils::Common.deep_compact!(tree_structure) if tree_structure.instance_of?(Hash)
      end

      # Perform validation over the defined parameters
      def check_requirements
        validate
      end

      # Build the Genesis API endpoint
      # Options:
      #   subdomain - the service /gateway, wpf, etc/
      #   path - the requested service /blacklists, threeds/threeds_method/<unique_id>, wpf/reconcile, etc/
      #   token - the MID configuration, appended to the end of the URL
      def build_request_url(options = { subdomain: 'gateway', path: '', token: '' })
        options  = parse_request_parameters(options)

        format('%{protocol}://%{sub}%{domain}:%{port}/%{path}', {
                 protocol: api_config.protocol || PROTOCOL_HTTPS,
                 sub:      @configuration.sub_domain(options[:subdomain]),
                 domain:   @configuration.endpoint,
                 port:     api_config.port || PORT_HTTPS,
                 path:     fetch_request_path(options)
               })
      end

      # Transform amount to minor currency format
      def transform_amount(amount, currency)
        return amount if amount.nil? || !GenesisRuby::Api::Constants::Currencies::Iso4217.valid?(currency)

        GenesisRuby::Utils::MoneyFormat.amount_to_exponent amount, currency
      end

      private

      # Parse the Request URL options
      def parse_request_parameters(options = { subdomain: 'gateway', token: '', path: '' })
        raise EndpointNotSetError if @configuration.endpoint.empty?

        {
          subdomain: options.fetch(:subdomain, 'gateway'),
          token:     options.fetch(:token, ''),
          path:      options.fetch(:path, '')
        }
      end

      # Fetch the request path by the given options
      def fetch_request_path(options = { path: '', token: '' })
        return options[:path] if options[:token].empty?

        format('%{path}/%{token}/', { path: options[:path], token: options[:token] })
      end

    end
  end
end
