# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::Financial::OnlineBankingPayments::Eps do
  let(:skip_customer_email) { true }
  let(:skip_customer_phone) { true }
  let(:test_required_fields) do
    %i[transaction_id amount currency billing_country]
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

    request.transaction_id     = Faker::Internet.uuid
    request.usage              = Faker::Lorem.sentence
    request.remote_ip          = Faker::Internet.ip_v4_address
    request.amount             = Faker::Number.decimal l_digits: 2, r_digits: 2
    request.currency           = 'EUR'
    request.return_success_url = Faker::Internet.url
    request.return_failure_url = Faker::Internet.url
    request.return_pending_url = Faker::Internet.url
    request.billing_country    = 'AT'

    request
  end

  describe 'when billing_country' do
    it 'with invalid value' do
      request.billing_country = 'US'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  describe 'when currency' do
    it 'with invalid value' do
      request.currency = 'USD'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  include_examples 'address info attributes examples'
  include_examples 'async attributes examples'
  include_examples 'pending attributes examples'
  include_examples 'payment attributes examples'
  include_examples 'base request examples'
  include_examples 'financial attributes examples'
end
