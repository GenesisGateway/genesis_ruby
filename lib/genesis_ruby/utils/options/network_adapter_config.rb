# frozen_string_literal: true

require 'genesis_ruby/utils/options/base'
require 'genesis_ruby/errors/invalid_argument_error'
require 'base64'

module GenesisRuby
  module Utils
    module Options
      # Configurable Options used for the API Request configuration
      class NetworkAdapterConfig < Base

        # Map the Adapter configuration from the Request object
        def map_from_request(request, configuration) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
          self.body          = request.build_document
          self.url           = request.api_config.url
          self.type          = request.api_config.type
          self.port          = request.api_config.port
          self.protocol      = request.api_config.protocol
          self.format        = fetch_content_type request.api_config.format
          self.authorization = request.api_config.authorization
          self.user_login    = build_user_login request, configuration
          self.setimeout     = configuration.timeout
          self.headers       = build_additional_headers request

          self
        end

        protected

        # Retrieve the Request data format that must be used as Content-Type header
        def fetch_content_type(data_format)
          case data_format
          when Builder::XML then 'text/xml'
          when Builder::JSON then 'application/json'
          when Builder::FORM then 'application/x-www-form-urlencoded'
          when Builder::GRAPHQL then 'application/graphql'
          when Builder::PATCH then 'application/json'
          else raise InvalidArgumentError, 'Invalid request format type. Allowed are XML, JSON, FORM AND PATCH'
          end
        end

        # Build the User login string used for the Authorization Header
        def build_user_login(request, configuration)
          auth = request.api_config.authorization
          kind = fetch_authorization_kind auth

          return "#{kind} #{request.api_config.bearer_token}" if auth == Api::Request::AUTH_TYPE_TOKEN

          "#{kind} #{Base64.urlsafe_encode64("#{configuration.username}:#{configuration.password}")}"
        end

        # Fetches the Request authorization kind
        # TODO: Add AUTH_TYPE_NONE, should be used for METHOD CONTINUE request
        def fetch_authorization_kind(auth)
          case auth
          when Api::Request::AUTH_TYPE_BASIC
            'Basic'
          when Api::Request::AUTH_TYPE_TOKEN
            'Bearer'
          else
            raise InvalidArgumentError, 'Invalid Authorization given in the Request. Allowed: BASIC, TOKEN'
          end
        end

        # Build additional headers to be added based on the specific request format
        def build_additional_headers(request)
          headers = {}

          headers.merge! 'Accept' => 'application/json' if request.api_config.format == Builder::GRAPHQL

          headers
        end

      end
    end
  end
end
