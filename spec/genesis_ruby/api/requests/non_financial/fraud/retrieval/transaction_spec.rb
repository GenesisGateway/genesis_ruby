RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Fraud::Retrieval::Transaction do
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

    request.arn = Faker::Internet.uuid

    request
  end

  describe 'when initialized' do
    it 'with valid endpoint' do
      expect(request.api_config[:url]).to eq 'https://staging.gate.emerchantpay.net:443/retrieval_requests'
    end

    it 'with XML root element' do
      expect(request.build_document).to include '<retrieval_request_request>'
    end

    it 'with arn' do
      expect(request.build_document).to include "<arn>#{request.arn}</arn>"
    end

    it 'with original_transaction_unique_id' do
      request.arn                            = nil
      request.original_transaction_unique_id = id = Faker::Internet.uuid

      expect(request.build_document).to include "<original_transaction_unique_id>#{id}</original_transaction_unique_id>"
    end

    it 'with original_transaction_unique_id and arn' do
      request.original_transaction_unique_id = Faker::Internet.uuid

      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end
  end

  include_examples 'base request examples'
  include_examples 'mode attributes examples'
end
