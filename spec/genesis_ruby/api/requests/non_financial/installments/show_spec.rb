# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Installments::Show do
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

    request.installment_id = 123

    request
  end

  it 'with proper request structure' do
    expect(request.build_document)
      .to eq '{}'
  end

  it 'with proper endpoint url' do
    request.build_document

    expect(request.api_config['url']).to eq 'https://staging.gate.emerchantpay.net:443/v1/installments/123'
  end

  it 'with string installment_id' do
    request.installment_id = 1

    expect(request.installment_id).to be_kind_of String
  end

  it 'with GET HTTP request type' do
    expect(request.api_config['type']).to eq 'GET'
  end

  include_examples 'base request examples'
  include_examples 'versioned request examples'
end
