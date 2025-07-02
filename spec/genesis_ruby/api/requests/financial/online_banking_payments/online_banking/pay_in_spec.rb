# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::Financial::OnlineBankingPayments::OnlineBanking::PayIn do
  let(:test_required_fields) do
    %i[transaction_id amount currency bank_code]
  end
  let(:test_required_field_values) { %i[payment_type currency] }
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
    request.currency           = 'AUD'
    request.usage              = Faker::Lorem.sentence
    request.remote_ip          = Faker::Internet.ip_v4_address
    request.return_success_url = Faker::Internet.url
    request.return_failure_url = Faker::Internet.url
    request.customer_email     = Faker::Internet.email
    request.customer_phone     = Faker::PhoneNumber.cell_phone
    request.bank_code          = GenesisRuby::Api::Constants::Transactions::Parameters::OnlineBanking::BankCodes::PID

    request
  end

  describe 'when bank code currencies' do
    it 'with invalid bank code' do
      request.bank_code = Faker::Lorem.word

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with proper currency and bank code' do
      request.currency  = 'CNY'
      request.bank_code = GenesisRuby::Api::Constants::Transactions::Parameters::OnlineBanking::BankCodes::CEB

      expect { request.build_document }.to_not raise_error
    end

    it 'with valid currency with valid bank code without valid pair' do
      request.currency  = 'EUR'
      request.bank_code = GenesisRuby::Api::Constants::Transactions::Parameters::OnlineBanking::BankCodes::AI

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  describe 'when optional params' do
    it 'without payment_type' do
      expect(request.build_document).to_not include 'payment_type'
    end

    it 'with payment_type' do
      request.payment_type = type = GenesisRuby::Api::Constants::Transactions::Parameters::OnlineBanking::
          PaymentTypes.all.sample

      expect(request.build_document).to include "<payment_type>#{type}</payment_type>"
    end

    it 'without user_category' do
      expect(request.build_document).to_not include 'user_category'
    end

    it 'with user_category' do
      request.user_category = category = 'default'

      expect(request.build_document).to include "<user_category>#{category}</user_category>"
    end

    it 'without consumer_reference' do
      expect(request.build_document).to_not include 'consumer_reference'
    end

    it 'with consumer_reference' do
      request.consumer_reference = reference = Faker::Internet.uuid

      expect(request.build_document).to include "<consumer_reference>#{reference}</consumer_reference>"
    end

    it 'without auth_code' do
      expect(request.build_document).to_not include 'auth_code'
    end

    it 'with auth_code' do
      request.auth_code = code = Faker::Number.positive

      expect(request.build_document).to include "<auth_code>#{code}</auth_code>"
    end
  end

  include_examples 'address info attributes examples'
  include_examples 'async attributes examples'
  include_examples 'base request examples'
  include_examples 'document attributes examples'
  include_examples 'financial attributes examples'
  include_examples 'payment attributes examples'
  include_examples 'virtual payment address attributes examples'
end
