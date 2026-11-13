# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Reconcile::Order do
  let(:configuration) do
    configuration             = GenesisRuby::Configuration.new
    configuration.username    = 'example_username'
    configuration.password    = 'example_password'
    configuration.token       = 'example_token'
    configuration.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    configuration.environment = GenesisRuby::Api::Constants::Environments::STAGING
    configuration
  end
  let(:request) do
    request          = described_class.new configuration
    request.order_id = Faker::Alphanumeric.alphanumeric number: 20
    request
  end
  let(:test_required_fields) { %i[order_id] }

  describe 'when initialized' do
    it 'with valid endpoint' do
      expect(request.api_config[:url])
        .to eq "https://staging.gate.emerchantpay.net:443/reconcile/by_order/#{configuration.token}/"
    end

    it 'with XML root element' do
      expect(request.build_document).to include '<reconcile>'
    end
  end

  include_examples 'base request examples'
  include_examples 'smart router attributes examples'
  include_examples 'reconcile order attributes examples'
end
