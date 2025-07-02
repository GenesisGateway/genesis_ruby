# frozen_string_literal: true

require 'genesis_ruby/api/constants/non_financial/kyc/create_transaction_payment_methods'
require 'genesis_ruby/api/constants/non_financial/kyc/order_sources'

RSpec.describe GenesisRuby::Api::Requests::NonFinancial::Kyc::Transaction::Create do
  let(:test_required_fields) do
    %i[
      transaction_unique_id transaction_created_at customer_ip_address first_name last_name
      customer_email address1 city province zip_code country payment_method
    ]
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

    request.transaction_unique_id  = Faker::Internet.uuid
    request.transaction_created_at = Faker::Time.backward(days: 14).strftime('%Y-%m-%d %H:%M:%S')
    request.customer_ip_address    = Faker::Internet.ip_v4_address
    request.first_name             = Faker::Name.first_name
    request.last_name              = Faker::Name.last_name
    request.customer_email         = Faker::Internet.email
    request.address1               = Faker::Address.street_address
    request.city                   = Faker::Address.city
    request.province               = Faker::Address.state
    request.zip_code               = Faker::Address.zip_code
    request.country                = GenesisRuby::Utils::Country::COUNTRIES.keys.sample
    request.payment_method         = GenesisRuby::Api::Constants::NonFinancial::Kyc::CreateTransactionPaymentMethods::PAYMENT_METHOD_CC # rubocop:disable Layout/LineLength
    request.bin                    = Faker::Number.number(digits: 6)
    request.tail                   = Faker::Number.number(digits: 4)

    request
  end

  describe 'when valid request' do
    it 'with request_path' do
      expect(request.__send__(:request_path)).to eq 'create_transaction'
    end

    it 'with only required attributes' do
      expect { request.build_document }.to_not raise_error
    end

    it 'with all attributes' do # rubocop:disable RSpec/ExampleLength
      request.session_id                       = Faker::Internet.uuid
      request.customer_username                = Faker::Internet.username
      request.customer_unique_id               = Faker::Alphanumeric.alphanumeric(number: 8)
      request.customer_status                  = Faker::Lorem.word
      request.customer_loyalty_level           = Faker::Number.between(from: 1, to: 5)
      request.customer_registration_date       = Faker::Date.backward(days: 365).strftime('%Y-%m-%d')
      request.customer_registration_ip_address = Faker::Internet.ip_v4_address
      request.customer_registration_device_id  = Faker::Internet.uuid
      request.customer_device_id               = Faker::Internet.uuid
      request.third_party_device_id            = Faker::Internet.uuid
      request.device_fingerprint               = Faker::Internet.uuid
      request.device_fingerprint_type          = Faker::Number.between(from: 1, to: 3)
      request.shopping_cart_items_count        = Faker::Number.between(from: 1, to: 10)
      request.order_source                     = GenesisRuby::Api::Constants::NonFinancial::Kyc::OrderSources.all.sample
      request.merchant_website                 = Faker::Internet.domain_name
      request.industry_type                    = Faker::Number.between(from: 1, to: 9)
      request.customer_password                = Faker::Internet.password
      request.address2                         = Faker::Address.secondary_address
      request.phone1                           = '12345678'
      request.phone2                           = Faker::PhoneNumber.cell_phone
      request.birth_date                       = Faker::Date.birthday(min_age: 18, max_age: 65).strftime('%Y-%m-%d')
      request.document_number                  = Faker::IDNumber.valid
      request.document_type                    = Faker::Number.between(from: 1, to: 3)
      request.gender                           = GenesisRuby::Api::Constants::NonFinancial::Kyc::Genders.all.sample
      request.first_deposit_date               = Faker::Date.backward(days: 365).strftime('%Y-%m-%d')
      request.first_withdrawal_date            = Faker::Date.backward(days: 180).strftime('%Y-%m-%d')
      request.deposits_count                   = Faker::Number.between(from: 1, to: 100)
      request.withdrawals_count                = Faker::Number.between(from: 1, to: 50)
      request.current_balance                  = Faker::Number.decimal(l_digits: 4, r_digits: 2)

      request.minimum                          = Faker::Number.decimal(l_digits: 2, r_digits: 2)
      request.daily_maximum                    = Faker::Number.decimal(l_digits: 4, r_digits: 2)
      request.weekly_maximum                   = Faker::Number.decimal(l_digits: 4, r_digits: 2)
      request.monthly_maximum                  = Faker::Number.decimal(l_digits: 5, r_digits: 2)

      request.billing_first_name               = Faker::Name.first_name
      request.billing_last_name                = Faker::Name.last_name
      request.billing_customer_email           = Faker::Internet.email
      request.billing_address1                 = Faker::Address.street_address
      request.billing_address2                 = Faker::Address.secondary_address
      request.billing_city                     = Faker::Address.city
      request.billing_province                 = Faker::Address.state
      request.billing_zip_code                 = Faker::Address.zip_code
      request.billing_country                  = GenesisRuby::Utils::Country::COUNTRIES.keys.sample
      request.billing_phone1                   = '12345678'
      request.billing_birth_date               = Faker::Date.birthday(min_age: 18, max_age: 65).strftime('%Y-%m-%d')
      request.billing_gender                   = GenesisRuby::Api::Constants::NonFinancial::Kyc::Genders.all.sample

      request.shipping_first_name              = Faker::Name.first_name
      request.shipping_last_name               = Faker::Name.last_name
      request.shipping_customer_email          = Faker::Internet.email
      request.shipping_address1                = Faker::Address.street_address
      request.shipping_address2                = Faker::Address.secondary_address
      request.shipping_city                    = Faker::Address.city
      request.shipping_province                = Faker::Address.state
      request.shipping_zip_code                = Faker::Address.zip_code
      request.shipping_country                 = GenesisRuby::Utils::Country::COUNTRIES.keys.sample
      request.shipping_phone1                  = '12345678'

      request.cvv_present                      = [true, false].sample
      request.hashed_pan                       = Faker::Crypto.sha256
      request.routing                          = Faker::Bank.routing_number
      request.account                          = Faker::Bank.account_number
      request.ewallet_id                       = Faker::Internet.uuid

      request.amount                           = Faker::Number.decimal(l_digits: 3, r_digits: 2)
      request.currency                         = Faker::Currency.code

      request.local_time                       = Faker::Time.forward(days: 23).iso8601
      request.transaction_status               = Faker::Number.between(from: 1, to: 3)
      request.rule_context                     = Faker::Number.number(digits: 5)
      request.custom_variable                  = Faker::Lorem.sentence

      expect { request.build_document }.to_not raise_error
    end
  end

  describe 'when invalid attributes' do
    it 'with invalid device_fingerprint_type' do
      request.device_fingerprint_type = 4
      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with invalid order_source' do
      request.order_source = 'invalid'
      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with invalid industry_type' do
      request.industry_type = 99
      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with invalid transaction_status' do
      request.transaction_status = 'invalid'
      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with invalid payment_method' do
      request.payment_method = 'invalid'
      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with payment_method with missing required fields' do
      request.payment_method = GenesisRuby::Api::Constants::NonFinancial::Kyc::CreateTransactionPaymentMethods::PAYMENT_METHOD_CC # rubocop:disable Layout/LineLength
      request.bin            = nil
      request.tail           = nil
      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  include_examples 'base request examples'
  include_examples 'versioned request examples'
  include_examples 'kyc billing info attributes examples'
  include_examples 'kyc shipping info attributes examples'
  include_examples 'payment details attributes examples'
  include_examples 'deposit limits attributes examples'
  include_examples 'customer information attributes examples'
end
