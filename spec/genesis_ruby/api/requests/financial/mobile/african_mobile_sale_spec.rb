# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::Financial::Mobile::AfricanMobileSale do
  let(:test_required_fields) do
    %i[transaction_id
       amount
       currency
       target
       customer_phone
       billing_country]
  end
  let(:test_required_field_values) { %i[currency billing_country] }
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
    request.currency           = 'KES'
    request.usage              = Faker::Lorem.sentence
    request.remote_ip          = Faker::Internet.ip_v4_address
    request.return_success_url = Faker::Internet.url
    request.return_failure_url = Faker::Internet.url
    request.operator           =
      GenesisRuby::Api::Constants::Transactions::Parameters::AfricanMobileOperators::SAFARICOM
    request.target             = Faker::Lorem.characters(number: 20)
    request.customer_email     = Faker::Internet.email
    request.customer_phone     = Faker::PhoneNumber.cell_phone_in_e164
    request.billing_country    = 'KE'

    request
  end

  describe 'when validations' do
    it 'with invalid currency' do
      request.currency = 'EUR'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with invalid billing_country' do
      request.billing_country = 'USA'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with invalid operator' do
      expect { request.operator = 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with invalid operator and currency combination' do
      request.operator =
        GenesisRuby::Api::Constants::Transactions::Parameters::AfricanMobileOperators::VODACOM

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  include_examples 'address info attributes examples'
  include_examples 'african mobile attributes examples'
  include_examples 'base request examples'
  include_examples 'financial attributes examples'
  include_examples 'payment attributes examples'
end
