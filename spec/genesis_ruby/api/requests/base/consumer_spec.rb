require 'spec/genesis_ruby/stubs/api/requests/base/consumer_stub'

RSpec.describe GenesisRuby::Api::Requests::Base::Consumer do
  let(:configuration) do
    configuration             = GenesisRuby::Configuration.new
    configuration.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    configuration.environment = GenesisRuby::Api::Constants::Environments::STAGING
    configuration.token       = '123'

    configuration
  end

  describe 'without implementation' do
    let(:request) { described_class.new configuration }

    it 'with proper builder interface' do
      expect(request.instance_variable_get('@builder_interface')).to eq 'xml'
    end

    it 'without request_structure' do
      expect { request.__send__(:populate_structure) }.to raise_error NoMethodError
    end
  end

  describe 'with implemented' do
    let(:request) { GenesisSpec::Stubs::Api::Requests::Base::ConsumerStub.new configuration }

    it 'with request_path' do
      expect(request.api_config['url']).to eq 'https://staging.gate.emerchantpay.net:443/v1/fake_path'
    end

    it 'with proper structure' do
      request.__send__(:populate_structure)

      expect(request.instance_variable_get('@tree_structure')).to be_kind_of Hash
    end

    it 'with proper root node' do
      expect(request.build_document).to include "<#{request.__send__(:request_path)}_request>"
    end

    include_examples 'base request examples'
    include_examples 'versioned request examples'
  end
end
