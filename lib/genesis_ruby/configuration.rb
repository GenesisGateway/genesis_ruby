require 'genesis_ruby/api/constants/environments'
require 'genesis_ruby/api/constants/endpoints'
require 'genesis_ruby/errors/invalid_argument_error'

module GenesisRuby
  # Class Configuration
  #
  # Store/Retrieve configuration key/values across the Genesis library
  class Configuration # rubocop:disable Metrics/ClassLength

    # Default Network Timeout
    DEFAULT_TIMEOUT = 60

    # Supported Network Connections
    NETWORK_INTERFACE_NET_HTTP = 'net-http'.freeze

    # Default Format Response
    DEFAULT_FORMAT_RESPONSE = true

    # Default sanitize Response
    DEFAULT_SANITIZE_RESPONSE = true

    # Genesis basic configuration - credentials, endpoint, environment, token, etc
    attr_writer :username, :password, :token, :interface, :format_response, :sanitize_response, :billing_api_token

    # Configuration constructor
    def initialize
      @environment = GenesisRuby::Api::Constants::Environments::STAGING
      @sub_domains = available_sub_domains
    end

    # Genesis Username
    def username
      @username ||= ''
    end

    # Genesis Password
    def password
      @password ||= ''
    end

    # Genesis Token required from some of the requests
    def token
      @token ||= ''
    end

    # Genesis Environment
    def environment
      @environment ||= ''
    end

    # Genesis endpoint
    def endpoint
      @endpoint ||= ''
    end

    # Genesis Request Timeout
    def timeout
      @timeout ||= DEFAULT_TIMEOUT
    end

    # Enable Smart Routing for Financial transaction requests
    def force_smart_routing
      @force_smart_routing ||= false
    end

    # Defines the Bearer token used for authorization in Billing API Service
    def billing_api_token
      @billing_api_token || ''
    end

    # Genesis Request Timeout
    def timeout=(value)
      timeout = value.to_i

      @timeout = timeout <= 0 ? DEFAULT_TIMEOUT : timeout
    end

    # Network Interface used for executing requests
    def interface
      @interface ||= NETWORK_INTERFACE_NET_HTTP
    end

    # Get a sub-domain host based on the environment
    def sub_domain(sub)
      return @sub_domains[sub.to_sym][@environment] if @sub_domains.key?(sub.to_sym)

      nil
    end

    # Environment setter
    def environment=(environment)
      environment_argument = environment.downcase
      parsed_env           = nil

      environment_aliases.each do |available_env, env_alias|
        parsed_env = available_env if env_alias.include? environment_argument
      end

      raise InvalidArgumentError, 'Invalid Environment' if parsed_env.nil?

      @environment = parsed_env
    end

    # Endpoint setter
    def endpoint=(endpoint)
      endpoint_argument = endpoint.downcase
      parsed_endpoint   = nil

      endpoint_aliases.each do |available_end, endpoint_alias|
        parsed_endpoint = available_end if endpoint_alias.include? endpoint_argument
      end

      raise InvalidArgumentError, 'Invalid Endpoint' if parsed_endpoint.nil?

      @endpoint = parsed_endpoint
    end

    # Indicates if the parsed Response from Genesis should be formatted
    def format_response
      return @format_response = DEFAULT_FORMAT_RESPONSE if @format_response.nil?

      @format_response
    end

    # Indicates if the parsed Response from Genesis should be sanitized
    def sanitize_response
      return @sanitize_response = DEFAULT_SANITIZE_RESPONSE if @sanitize_response.nil?

      @sanitize_response
    end

    # Enable Smart Routing for Financial transaction requests
    def force_smart_routing=(value)
      unless [true, false].include? value
        raise InvalidArgumentError, 'Given invalid Force Smart Routing value! Allowed: true, false'
      end

      @force_smart_routing = value
    end

    private

    # Various definitions for environment
    # rubocop:disable Metrics/MethodLength
    def environment_aliases
      {
        GenesisRuby::Api::Constants::Environments::STAGING    => [
          'test',
          'testing',
          'staging',
          GenesisRuby::Api::Constants::Environments::STAGING
        ],
        GenesisRuby::Api::Constants::Environments::PRODUCTION => [
          'live',
          'prod',
          'production',
          GenesisRuby::Api::Constants::Environments::PRODUCTION
        ]
      }
    end

    # Various definitions for Genesis endpoint
    def endpoint_aliases
      {
        GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY   => [
          'emp',
          'emerchantpay',
          GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
        ],
        GenesisRuby::Api::Constants::Endpoints::ECOMPROCESSING => [
          'ecp',
          'ecomprocessing',
          'e-comprocessing',
          GenesisRuby::Api::Constants::Endpoints::ECOMPROCESSING
        ]
      }
    end
    # rubocop:enable Metrics/MethodLength

    # Available Genesis subdomains
    def available_sub_domains # rubocop:disable Metrics/MethodLength
      {
        gateway:      {
          GenesisRuby::Api::Constants::Environments::PRODUCTION => 'gate.',
          GenesisRuby::Api::Constants::Environments::STAGING    => 'staging.gate.'
        },
        wpf:          {
          GenesisRuby::Api::Constants::Environments::PRODUCTION => 'wpf.',
          GenesisRuby::Api::Constants::Environments::STAGING    => 'staging.wpf.'
        },
        smart_router: {
          GenesisRuby::Api::Constants::Environments::PRODUCTION => 'prod.api.',
          GenesisRuby::Api::Constants::Environments::STAGING    => 'staging.api.'
        },
        api_service:  {
          GenesisRuby::Api::Constants::Environments::PRODUCTION => 'prod.api.',
          GenesisRuby::Api::Constants::Environments::STAGING    => 'staging.api.'
        },
        kyc_service:  {
          GenesisRuby::Api::Constants::Environments::PRODUCTION => 'prod.kyc.',
          GenesisRuby::Api::Constants::Environments::STAGING    => 'staging.kyc.'
        }
      }
    end

  end
end
