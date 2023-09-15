require 'genesis_ruby/api/request'
require 'spec/genesis_ruby/shared_examples/api/request_examples'

RSpec.describe GenesisRuby::Api::Request do
  describe 'with undefined configuration' do
    let(:request) do
      described_class.new(GenesisRuby::Configuration.new)
    end

    it 'has proper initialization' do
      expect(request.class.to_s).to eq('GenesisRuby::Api::Request')
    end

    it 'can build document' do
      expect(request.build_document).to eq("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n")
    end

    it 'can not init api gateway configuration' do
      expect { request.__send__(:init_api_gateway_configuration) }.to raise_error(GenesisRuby::EndpointNotSetError)
    end
  end

  describe 'with defined configuration' do
    genesis_configuration      = GenesisRuby::Configuration.new

    base_request_configuration = {
      protocol: described_class::PROTOCOL_HTTPS,
      port:     described_class::PORT_HTTPS,
      type:     described_class::METHOD_POST,
      url:      'https://staging.gate.emerchantpay.net:443/process/token/'
    }

    xml_request_configuration  = base_request_configuration.merge({ format: 'xml' })
    json_request_configuration = base_request_configuration.merge({ format: 'json' })
    form_request_configuration = base_request_configuration.merge({ format: 'form' })

    let(:request) do
      genesis_configuration.username    = 'username'
      genesis_configuration.password    = 'password'
      genesis_configuration.token       = 'token'
      genesis_configuration.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
      genesis_configuration.environment = GenesisRuby::Api::Constants::Environments::STAGING

      described_class.new(genesis_configuration)
    end

    it 'init proper XML configuration' do
      request.__send__ :init_xml_configuration
      request.__send__ :init_api_gateway_configuration

      expect(request.api_config).to eq(xml_request_configuration)
    end

    it 'init proper JSON configuration' do
      request.__send__ :init_json_configuration
      request.__send__ :init_api_gateway_configuration

      expect(request.api_config).to eq(json_request_configuration)
    end

    it 'init proper FORM configuration' do
      request.__send__ :init_form_configuration
      request.__send__ :init_api_gateway_configuration

      expect(request.api_config).to eq(form_request_configuration)
    end

    include_examples(
      'request examples',
      GenesisRuby::Api::Constants::Environments::STAGING,
      GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    )

    include_examples(
      'request examples',
      GenesisRuby::Api::Constants::Environments::PRODUCTION,
      GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    )

    include_examples(
      'request examples',
      GenesisRuby::Api::Constants::Environments::STAGING,
      GenesisRuby::Api::Constants::Endpoints::ECOMPROCESSING
    )

    include_examples(
      'request examples',
      GenesisRuby::Api::Constants::Environments::PRODUCTION,
      GenesisRuby::Api::Constants::Endpoints::ECOMPROCESSING
    )
  end
end
