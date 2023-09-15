# rubocop:disable Layout/LineLength
require 'genesis_ruby/api/requests/base/financial'
require 'spec/genesis_ruby/stubs/api/requests/base/financial_stub'

RSpec.describe GenesisRuby::Api::Requests::Base::Financial do
  let(:configuration) do
    configuration             = GenesisRuby::Configuration.new
    configuration.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    configuration.environment = GenesisRuby::Api::Constants::Environments::STAGING

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
      expect(financial.api_config[:url]).to eq 'https://staging.gate.emerchantpay.net:443/process'
    end
  end

  describe 'with implementation' do
    let(:financial) { GenesisSpec::Stubs::Api::Requests::Base::FinancialStub.new configuration }

    it 'with root payment_transaction key' do
      expect(financial.populate_structure).to include :payment_transaction
    end

    it 'with transaction_type key' do
      expect(financial.populate_structure[:payment_transaction]).to include :transaction_type
    end

    it 'with transaction_id key' do
      expect(financial.populate_structure[:payment_transaction]).to include :transaction_id
    end

    it 'with usage key' do
      expect(financial.populate_structure[:payment_transaction]).to include :usage
    end

    it 'with remote_ip key' do
      expect(financial.populate_structure[:payment_transaction]).to include :remote_ip
    end

    it 'can build structure' do
      structure = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<payment_transaction>\n  <transaction_type>sale</transaction_type>\n</payment_transaction>\n"

      expect(financial.build_document).to eq structure
    end
  end
end
# rubocop:enable Layout/LineLength
