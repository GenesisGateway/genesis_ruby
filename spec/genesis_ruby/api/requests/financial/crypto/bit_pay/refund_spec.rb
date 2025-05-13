RSpec.describe GenesisRuby::Api::Requests::Financial::Crypto::BitPay::Refund do
  let(:test_required_fields) do
    %i[transaction_id amount currency reference_id]
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

    request.transaction_id = Faker::Internet.uuid
    request.amount         = Faker::Number.decimal l_digits: 2, r_digits: 2
    request.currency       = 'USD'
    request.usage          = Faker::Lorem.sentence
    request.remote_ip      = Faker::Internet.ip_v4_address
    request.reference_id   = Faker::Internet.uuid

    request
  end

  include_examples 'base request examples'
  include_examples 'financial attributes examples'
  include_examples 'payment attributes examples'
  include_examples 'reference attributes examples'
end
