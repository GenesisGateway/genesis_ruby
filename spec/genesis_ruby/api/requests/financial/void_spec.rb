# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::Financial::Void do
  let(:configuration) do
    config             = GenesisRuby::Configuration.new
    config.username    = 'example_username'
    config.password    = 'example_password'
    config.token       = 'example_token'
    config.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY
    config.environment = GenesisRuby::Api::Constants::Environments::STAGING

    config
  end

  let(:request) do
    request = described_class.new configuration

    request.transaction_id     = Faker::Internet.uuid
    request.usage              = Faker::Lorem.sentence
    request.remote_ip          = Faker::Internet.ip_v4_address
    request.reference_id       = Faker::Internet.uuid

    request
  end

  it 'with proper URL' do
    expect(request.api_config.url).to eq 'https://staging.gate.emerchantpay.net:443/process/example_token/'
  end

  include_examples 'base request examples'
  include_examples 'reference attributes examples'
  include_examples 'smart router attributes examples'
end
