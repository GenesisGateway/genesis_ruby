RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Reconcile::Transaction do
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
      expect(request.api_config[:url]).to eq "https://staging.gate.emerchantpay.net:443/reconcile/#{config.token}/"
    end

    it 'with XML root element' do
      expect(request.build_document).to include '<reconcile>'
    end

    it 'with unique_id' do
      expect(request.build_document).to include "<unique_id>#{request.unique_id}</unique_id>"
    end

    it 'with transaction_id' do
      request.unique_id      = nil
      request.transaction_id = Faker::Internet.uuid

      expect(request.build_document).to include "<transaction_id>#{request.transaction_id}</transaction_id>"
    end

    it 'with arn' do
      request.unique_id = nil
      request.arn       = Faker::Internet.uuid

      expect(request.build_document).to include "<arn>#{request.arn}</arn>"
    end
  end

  include_examples 'base request examples'
end
