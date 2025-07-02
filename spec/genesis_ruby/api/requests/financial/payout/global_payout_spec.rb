# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::Financial::Payout::GlobalPayout do
  let(:test_required_fields) { %i[transaction_id amount currency payee_account_id] }

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

    request.transaction_id       = Faker::Internet.uuid
    request.amount               = Faker::Number.decimal l_digits: 2, r_digits: 2
    request.currency             = 'EUR'
    request.usage                = Faker::Lorem.sentence
    request.remote_ip            = Faker::Internet.ip_v4_address
    request.payee_account_id     = Faker::Internet.uuid

    request
  end

  it 'with required parameters' do
    expect { request.build_document }.to_not raise_error
  end

  it 'with all parameters' do # rubocop:disable RSpec/ExampleLength
    request.billing_first_name   = Faker::Name.first_name
    request.billing_last_name    = Faker::Name.last_name
    request.billing_address1     = Faker::Address.street_address
    request.billing_address2     = Faker::Address.street_address
    request.billing_zip_code     = Faker::Address.street_address
    request.billing_city         = Faker::Address.city
    request.billing_neighborhood = Faker::Address.city
    request.billing_state        = Faker::Address.state
    request.billing_country      = 'DE'

    expect { request.build_document }.to_not raise_error
  end

  it 'with payee_account_id' do
    request.payee_account_id = id = Faker::Internet.uuid

    expect(request.build_document).to include "<payee_account_id>#{id}</payee_account_id>"
  end

  include_examples 'base request examples'
  include_examples 'financial attributes examples'
  include_examples 'payment attributes examples'
end
