# frozen_string_literal: true

require 'spec/genesis_ruby/stubs/api/requests/base/versioned_stub'

RSpec.describe GenesisRuby::Api::Requests::Base::Versioned do
  let(:configuration) do
    configuration             = GenesisRuby::Configuration.new
    configuration.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    configuration.environment = GenesisRuby::Api::Constants::Environments::STAGING

    configuration
  end

  describe 'without implementation' do
    let(:versioned) { described_class.new configuration }
    let(:fake_versions) { %w(v1 v2) }

    it 'when version with default value' do
      expect(versioned.version).to eq 'v1'
    end

    it 'when version with invalid valid' do
      expect { versioned.version = 'v2' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'when version with allowed versions' do
      versioned.__send__ :allowed_versions=, fake_versions
      versioned.version = 'v2'

      expect(versioned.version).to eq 'v2'
    end

    it 'when version with proper url' do
      versioned.__send__ :allowed_versions=, fake_versions
      versioned.version = 'v2'

      expect(versioned.api_config['url']).to eq 'https://staging.gate.emerchantpay.net:443/v2/'
    end

    it 'when allowed_versions with default value' do
      expect(versioned.allowed_versions).to eq ['v1']
    end

    it 'when allowed_version with defined value' do
      versioned.__send__ :allowed_versions=, fake_versions

      expect(versioned.__send__(:allowed_versions)).to eq fake_versions
    end

    it 'when request_path with default value' do
      expect(versioned.__send__(:request_path)).to eq ''
    end

    it 'when request_path with defined value' do
      versioned.__send__ :request_path=, 'path'

      expect(versioned.__send__(:api_config)['url']).to eq 'https://staging.gate.emerchantpay.net:443/v1/path'
    end

    it 'when builder_interface with default JSON builder' do
      expect(versioned.instance_variable_get('@builder_interface')).to eq 'json'
    end

    it 'when JSON builder interface with default configuration' do
      expect(versioned.api_config[:format]).to eq 'json'
    end

    it 'when request_structure without implementation' do
      expect { versioned.__send__(:request_structure) }.to raise_error NoMethodError
    end

    it 'when populate_structure without implementation' do
      expect { versioned.__send__(:populate_structure) }.to raise_error NoMethodError
    end
  end

  describe 'with implementation' do
    let(:request) { GenesisSpec::Stubs::Api::Requests::Base::VersionedStub.new configuration }

    it 'with request_path' do
      expect(request.api_config['url']).to eq 'https://staging.gate.emerchantpay.net:443/v1/fake_path'
    end

    it 'with populated_structure' do
      request.__send__(:populate_structure)

      expect(request.instance_variable_get('@tree_structure')).to be_kind_of Hash
    end

    include_examples 'base request examples'
    include_examples 'versioned request examples'
  end
end
