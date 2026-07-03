# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Payee::Verifications::CreatePayeeVerification do
  let(:test_required_fields) { %i[payee_unique_id] }
  let(:config) do
    config = GenesisRuby::Configuration.new
    config.username = 'example_username'
    config.password = 'example_password'
    config.token = 'example_token'
    config.endpoint = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    config.environment = GenesisRuby::Api::Constants::Environments::STAGING

    config
  end
  let(:sample_data) do
    {
      payee_unique_id:   Faker::Internet.uuid,
      notification_url:  Faker::Internet.url,
      redirect_url:      Faker::Internet.url,
      with_checks_retry: [true, false].sample
    }
  end
  let(:request) do
    request = described_class.new config

    request.payee_unique_id = sample_data[:payee_unique_id]
    request.notification_url = sample_data[:notification_url]
    request.redirect_url = sample_data[:redirect_url]
    request.with_checks_retry = sample_data[:with_checks_retry]

    request
  end

  it 'when building document with proper request structure' do # rubocop:disable RSpec/MultipleExpectations
    parsed = JSON.parse(request.build_document)

    expect(parsed['verification']['notification_url']).to eq sample_data[:notification_url]
    expect(parsed['verification']['redirect_url']).to eq sample_data[:redirect_url]
    expect(parsed['verification']['with_checks_retry']).to eq sample_data[:with_checks_retry]
  end

  it 'when configured with proper endpoint url' do
    request.build_document

    expect(request.api_config['url']).to eq(
      "https://staging.api.emerchantpay.net:443/payee/#{sample_data[:payee_unique_id]}/verifications"
    )
  end

  it 'when using POST HTTP request type' do
    expect(request.api_config['type']).to eq 'POST'
  end

  it 'when configured without token in configuration' do
    request.build_document

    expect(request.api_config['token']).to be_nil
  end

  context 'when validating fields' do
    it 'with missing payee_unique_id should raise error' do
      request.payee_unique_id = nil
      expect { request.build_document }.to raise_error(GenesisRuby::ParameterError)
    end

    it 'with valid parameters should not raise error' do
      expect { request.build_document }.to_not raise_error
    end
  end

  context 'when processing request parameters' do
    it 'replaces placeholder in request path with actual payee_unique_id' do
      request.payee_unique_id = 'custom_payee_789'
      request.build_document

      expect(request.api_config['url']).to include('payee/custom_payee_789/verifications')
    end
  end

  include_examples 'base request examples'
end
