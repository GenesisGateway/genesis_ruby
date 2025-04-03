RSpec.describe GenesisRuby::Api::Requests::Financial::Wallets::Alipay do
  let(:test_required_fields) { %i[transaction_id amount currency] }
  let(:test_required_field_values) { %i[currency] }
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

    request.transaction_id     = Faker::Internet.uuid
    request.amount             = Faker::Number.decimal l_digits: 2, r_digits: 2
    request.currency           = 'EUR'
    request.usage              = Faker::Lorem.sentence
    request.remote_ip          = Faker::Internet.ip_v4_address
    request.return_success_url = Faker::Internet.url
    request.return_failure_url = Faker::Internet.url

    request
  end

  it 'when return_success_url without value' do # rubocop:disable RSpec/ExampleLength
    request                    = described_class.new config
    request.transaction_id     = Faker::Internet.uuid
    request.amount             = Faker::Number.decimal l_digits: 2, r_digits: 2
    request.currency           = 'EUR'
    request.return_failure_url = Faker::Internet.url

    expect { request.build_document }.to raise_error GenesisRuby::ParameterError
  end

  it 'when return_failure_url without value' do # rubocop:disable RSpec/ExampleLength
    request                    = described_class.new config
    request.transaction_id     = Faker::Internet.uuid
    request.amount             = Faker::Number.decimal l_digits: 2, r_digits: 2
    request.currency           = 'EUR'
    request.return_success_url = Faker::Internet.url

    expect { request.build_document }.to raise_error GenesisRuby::ParameterError
  end

  include_examples 'address info attributes examples'
  include_examples 'async attributes examples'
  include_examples 'base request examples'
  include_examples 'birth date attributes examples'
  include_examples 'financial attributes examples'
  include_examples 'payment attributes examples'
end
