RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Tokenization::GetCard do
  let(:test_required_fields) do
    %i[consumer_id email token_type token]
  end
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

    request.consumer_id = Faker::Internet.uuid[..9]
    request.email       = Faker::Internet.email
    request.token_type  = Faker::Lorem.word
    request.token       = Faker::Lorem.characters(number: 36)

    request
  end

  describe 'when initialized' do
    it 'with valid endpoint' do
      expect(request.api_config[:url]).to eq 'https://staging.gate.emerchantpay.net:443/v1/get_card'
    end

    it 'with XML root element' do
      expect(request.build_document).to include '<get_card_request>'
    end
  end

  include_examples 'base request examples'
  include_examples 'token attributes examples'
  include_examples 'tokenization api attributes examples'
  include_examples 'versioned request examples'
end
