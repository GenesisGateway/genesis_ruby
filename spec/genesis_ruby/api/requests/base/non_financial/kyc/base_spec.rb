# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::Base::NonFinancial::Kyc::Base do
  let(:configuration) do
    configuration             = GenesisRuby::Configuration.new
    configuration.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    configuration.environment = GenesisRuby::Api::Constants::Environments::STAGING

    configuration
  end

  let(:request) { described_class.new configuration }

  describe 'without implementation' do
    it 'with proper builder interface' do
      expect(request.instance_variable_get('@builder_interface')).to eq 'json'
    end

    it 'with api gateway configuration' do

      expect(request.api_config[:url]).to eq 'https://staging.kyc.emerchantpay.net:443/api/v1/'
    end
  end

  include_examples 'base request examples'
end
