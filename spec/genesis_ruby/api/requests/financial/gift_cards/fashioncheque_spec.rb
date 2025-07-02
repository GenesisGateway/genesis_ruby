# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::Financial::GiftCards::Fashioncheque do
  let(:test_required_fields) do
    %i[transaction_id amount currency]
  end
  let(:skip_customer_phone) { true }
  let(:skip_customer_email) { true }

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
    request.currency       = 'EUR'
    request.usage          = Faker::Lorem.sentence
    request.remote_ip      = Faker::Internet.ip_v4_address
    request.token          = Faker::Lorem.characters(number: 36)
    request.card_number    = Faker::Number.number(digits: 21)
    request.cvv            = Faker::Number.number(digits: 5)

    request
  end

  include_examples 'address info attributes examples'
  include_examples 'base request examples'
  include_examples 'dynamic descriptor examples'
  include_examples 'financial attributes examples'
  include_examples 'gift cards attributes examples'
  include_examples 'payment attributes examples'
  include_examples 'reference attributes examples'
  include_examples 'token attributes examples'
end
