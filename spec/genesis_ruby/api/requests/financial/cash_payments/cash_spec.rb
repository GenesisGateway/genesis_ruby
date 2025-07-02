# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::Financial::CashPayments::Cash do
  let(:test_required_fields) { %i[transaction_id amount currency payment_type document_id billing_country] }
  let(:test_required_field_values) { %i[currency payment_type] }
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
    request.usage              = Faker::Lorem.sentence
    request.remote_ip          = Faker::Internet.ip_v4_address
    request.amount             = Faker::Number.decimal l_digits: 2, r_digits: 2
    request.currency           = 'MXN'
    request.return_success_url = Faker::Internet.url
    request.return_failure_url = Faker::Internet.url
    request.document_id        = Faker::Internet.uuid
    request.payment_type       = GenesisRuby::Api::Constants::Transactions::Parameters::CashPayments::
        CashPaymentTypes.all.sample
    request.billing_country    = 'MX'

    request
  end

  include_examples 'address info attributes examples'
  include_examples 'async attributes examples'
  include_examples 'base request examples'
  include_examples 'document attributes examples'
  include_examples 'financial attributes examples'
  include_examples 'payment attributes examples'
end
