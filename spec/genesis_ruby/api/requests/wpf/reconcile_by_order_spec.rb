# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::Wpf::ReconcileByOrder do
  let(:config) do
    config             = GenesisRuby::Configuration.new
    config.username    = 'example_username'
    config.password    = 'example_password'
    config.token       = 'example_token'
    config.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    config.environment = GenesisRuby::Api::Constants::Environments::STAGING
    config
  end
  let(:request) do
    request          = described_class.new config
    request.order_id = Faker::Alphanumeric.alphanumeric number: 20
    request
  end
  let(:test_required_fields) { %i[order_id] }

  describe 'when initialized' do
    it 'with valid endpoint' do
      expect(request.api_config[:url]).to eq 'https://staging.wpf.emerchantpay.net:443/wpf/reconcile/by_order'
    end

    it 'with XML root element' do
      expect(request.build_document).to include '<wpf_reconcile>'
    end
  end

  include_examples 'base request examples'
  include_examples 'reconcile order attributes examples'
end
