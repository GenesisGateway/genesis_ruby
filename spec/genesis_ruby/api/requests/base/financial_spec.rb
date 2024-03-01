require 'genesis_ruby/api/requests/base/financial'
require 'spec/genesis_ruby/stubs/api/requests/base/financial_stub'

RSpec.describe GenesisRuby::Api::Requests::Base::Financial do
  let(:token) { Faker::Internet.uuid }
  let(:configuration) do
    configuration             = GenesisRuby::Configuration.new
    configuration.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    configuration.environment = GenesisRuby::Api::Constants::Environments::STAGING
    configuration.token       = token

    configuration
  end

  describe 'without implementation' do
    let(:financial) { described_class.new configuration }

    it 'with error when transaction_type' do
      expect { financial.__send__(:transaction_type) }.to raise_error NotImplementedError
    end

    it 'with error when payment_transaction_structure' do
      expect { financial.__send__(:payment_transaction_structure) }.to raise_error NotImplementedError
    end

    it 'with error when populate_structure' do
      expect { financial.__send__(:populate_structure) }.to raise_error NotImplementedError
    end

    it 'with xml configuration' do
      expect(financial.api_config[:format]).to eq 'xml'
    end

    it 'with api gateway configuration' do
      expect(financial.api_config[:url]).to eq "https://staging.gate.emerchantpay.net:443/process/#{token}/"
    end
  end

  describe 'with implementation' do
    let(:request) do
      request = GenesisSpec::Stubs::Api::Requests::Base::FinancialStub.new configuration

      request.transaction_id = Faker::Internet.uuid
      request.usage          = Faker::Lorem.sentence
      request.remote_ip      = Faker::Internet.ip_v4_address

      request
    end

    it 'with force_smart_routing' do
      configuration.force_smart_routing = true

      request.build_document

      expect(request.api_config.url).to eq 'https://staging.api.emerchantpay.net:443/transactions'
    end

    it 'with use_smart_router' do
      configuration.force_smart_routing = false
      request.use_smart_router = true

      request.build_document

      expect(request.api_config.url).to eq 'https://staging.api.emerchantpay.net:443/transactions'
    end

    include_examples 'base request examples'
    include_examples 'financial structure examples'
    include_examples 'financial attributes examples'
  end
end
