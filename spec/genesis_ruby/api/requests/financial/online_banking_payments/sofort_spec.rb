RSpec.describe GenesisRuby::Api::Requests::Financial::OnlineBankingPayments::Sofort do
  let(:test_required_fields) do
    %i[transaction_id remote_ip amount currency customer_email billing_country]
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
    request = described_class.new(config)
    request.transaction_id     = Faker::Internet.uuid
    request.amount             = Faker::Number.decimal(l_digits: 2, r_digits: 2)
    request.currency           = 'EUR'
    request.usage              = Faker::Lorem.sentence
    request.customer_email     = Faker::Internet.email
    request.customer_phone     = Faker::PhoneNumber.cell_phone
    request.remote_ip          = Faker::Internet.ip_v4_address
    request.notification_url   = Faker::Internet.url
    request.return_success_url = Faker::Internet.url
    request.return_failure_url = Faker::Internet.url
    request.return_pending_url = Faker::Internet.url
    request.bic                = Faker::Bank.swift_bic
    request.iban               = Faker::Bank.iban
    request.billing_country    = 'DE'

    request
  end

  describe 'with billing_country' do
    it 'when invalid country' do
      request.billing_country = 'CL'
      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  include_examples 'bank attributes examples'
  include_examples 'address info attributes examples'
  include_examples 'async attributes examples'
  include_examples 'base request examples'
  include_examples 'payment attributes examples'
  include_examples 'pending attributes examples'
  include_examples 'financial attributes examples'
end
