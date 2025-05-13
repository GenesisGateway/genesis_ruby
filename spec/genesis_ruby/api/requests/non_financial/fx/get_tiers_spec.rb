RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Fx::GetTiers do
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

    request
  end

  it 'with proper request structure' do
    expect(request.build_document).to eq '{}'
  end

  it 'with proper endpoint url' do
    request.build_document

    expect(request.api_config['url'])
      .to eq 'https://staging.gate.emerchantpay.net:443/v1/fx/tiers'
  end

  it 'with GET HTTP request type' do
    expect(request.api_config['type']).to eq 'GET'
  end

  include_examples 'base request examples'
  include_examples 'versioned request examples'
end
