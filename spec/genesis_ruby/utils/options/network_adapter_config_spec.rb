require 'genesis_ruby/utils/options/base'
require 'genesis_ruby/utils/options/network_adapter_config'
require 'genesis_ruby/api/request'
require 'base64'

RSpec.describe GenesisRuby::Utils::Options::NetworkAdapterConfig do
  let(:options) { described_class.new }
  let(:configuration) do
    config             = GenesisRuby::Configuration.new
    config.username    = 'example_username'
    config.password    = 'example_password'
    config.token       = 'example_token'
    config.environment = GenesisRuby::Api::Constants::Environments::STAGING
    config.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY

    config
  end
  let(:request) { GenesisRuby::Api::Request.new configuration }
  let(:encoded_login) { Base64.urlsafe_encode64 "#{configuration.username}:#{configuration.password}" }

  include_examples 'option examples'

  describe 'when Not Configured Request' do
    it 'without format' do
      expect { options.map_from_request(request, configuration) }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with nil authorization' do
      request.api_config.format = 'xml'

      expect { options.map_from_request(request, configuration) }.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when XML request' do
    before do
      request.__send__ :init_xml_configuration
      request.__send__ :init_api_gateway_configuration
      options.map_from_request(request, configuration)
    end

    it 'with XML format' do
      expect(options).to include format: 'text/xml'
    end

    it 'with Basic authorization' do
      expect(options).to include authorization: 'basic'
    end

    it 'with Basic authorization login' do
      expect(options).to include user_login: "Basic #{encoded_login}"
    end

    it 'with additional headers' do
      expect(options).to include headers: {}
    end
  end

  describe 'when JSON request' do
    before do
      request.__send__ :init_json_configuration
      request.__send__ :init_api_gateway_configuration
      options.map_from_request(request, configuration)
    end

    it 'with JSON format' do
      expect(options).to include format: 'application/json'
    end

    it 'with Basic authorization' do
      expect(options).to include authorization: 'basic'
    end

    it 'with Basic authorization login' do
      expect(options).to include user_login: "Basic #{encoded_login}"
    end

    it 'with additional headers' do
      expect(options).to include headers: {}
    end
  end

  describe 'when FORM request' do
    before do
      request.__send__ :init_form_configuration
      request.__send__ :init_api_gateway_configuration
      options.map_from_request(request, configuration)
    end

    it 'with FORM format' do
      expect(options).to include format: 'application/x-www-form-urlencoded'
    end

    # TODO: Method Continue doesn't have Auth, consider adding authorization: none
    it 'with Basic authorization' do
      expect(options).to include authorization: 'basic'
    end

    # TODO: Method Continue doesn't have Auth, consider leave user_login empty
    it 'with authorization login' do
      expect(options).to include user_login: "Basic #{encoded_login}"
    end

    it 'with additional headers' do
      expect(options).to include headers: {}
    end
  end

  describe 'when GET request' do
    before do
      request.__send__ :init_get_configuration
      request.__send__ :init_api_gateway_configuration
      options.map_from_request(request, configuration)
    end

    it 'without format' do
      expect(options).to include type: 'GET'
    end

    it 'with Basic authorization' do
      expect(options).to include authorization: 'basic'
    end

    it 'with authorization login' do
      expect(options).to include user_login: "Basic #{encoded_login}"
    end

    it 'with additional headers' do
      expect(options).to include headers: {}
    end
  end

  describe 'when GraphQL request' do
    let(:token) { Faker::Internet.uuid }

    before do
      request.__send__ :init_graphql_configuration
      request.__send__ :init_api_service_configuration
      request.api_config.bearer_token = token
      options.map_from_request(request, configuration)
    end

    it 'with GraphQL format' do
      expect(options).to include format: 'application/graphql'
    end

    it 'with Bearer authorization' do
      expect(options).to include authorization: 'bearer'
    end

    it 'with authorization login' do
      expect(options).to include user_login: "Bearer #{token}"
    end

    it 'with additional headers' do
      expect(options).to include headers: { 'Accept' => 'application/json' }
    end
  end
end
