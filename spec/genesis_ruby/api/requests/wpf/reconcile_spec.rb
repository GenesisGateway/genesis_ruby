RSpec.describe GenesisRuby::Api::Requests::Wpf::Reconcile do
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
    request = described_class.new config

    request.unique_id = Faker::Internet.uuid

    request
  end

  describe 'when initialized' do
    it 'with valid endpoint' do
      expect(request.api_config[:url]).to eq 'https://staging.wpf.emerchantpay.net:443/wpf/reconcile'
    end

    it 'with XML root element' do
      expect(request.build_document).to include '<wpf_reconcile>'
    end

    it 'with unique_id' do
      expect(request.build_document).to include "<unique_id>#{request.unique_id}</unique_id>"
    end
  end

  include_examples 'base request examples'
end
