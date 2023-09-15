require 'genesis_ruby/version'
require 'genesis_ruby/configuration'
require 'genesis_ruby/connection'
require 'genesis_ruby/api/constants/transactions'
require 'genesis_ruby/dependencies'
require 'genesis_ruby/api/response'

# Ruby Client for Genesis Payment Processing Gateway
module GenesisRuby
  # Base SDK class
  class Genesis

    # Transaction Request Initializer
    def self.for(config:, request:)
      unless request.is_a?(Class) || request < GenesisRuby::Api::Request
        raise InvalidArgumentError, 'Given Request is invalid'
      end

      request_object = request.new(config)

      raise InvalidArgumentError, 'Request Block missing' unless block_given?

      yield request_object

      new config, request_object
    end

    attr_reader :request, :configuration, :response

    # Initialize the Library
    def initialize(configuration, request = nil)
      @configuration = configuration
      @request       = request
      @response      = GenesisRuby::Api::Response.new(configuration)
      @network       = GenesisRuby::Connection.for(configuration)
    end

    # Execute the Request
    def execute
      # Initialize the Network Connection with the given request
      @network.init_api_data(@request)

      # Send the Request payload to Genesis
      @network.send_request

      # Parse the Response
      @response.parse_response(@network)

      self
    end

    protected

    attr_reader :network

  end
end
