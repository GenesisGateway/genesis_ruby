# frozen_string_literal: true

RSpec.describe GenesisRuby::Api::Requests::Financial::OnlineBankingPayments::Idebit::PayIn do
  let(:test_required_fields) do
    %i[transaction_id amount currency customer_account_id billing_country]
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

    request.transaction_id      = Faker::Internet.uuid
    request.amount              = Faker::Number.decimal l_digits: 2, r_digits: 2
    request.currency            = 'CAD'
    request.usage               = Faker::Lorem.sentence
    request.remote_ip           = Faker::Internet.ip_v4_address
    request.customer_email      = Faker::Internet.email
    request.customer_phone      = Faker::PhoneNumber.cell_phone
    request.customer_account_id = Faker::Number.number(digits: 10)
    request.birth_date          = '1970-01-01'
    request.billing_country     = 'CA'

    request
  end

  describe 'with billing_country' do
    it 'when proper billing_country' do
      expect { request.build_document }.to_not raise_error
    end

    it 'when invalid billing_country' do
      request.billing_country = 'US'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  describe 'with minimum attributes' do
    it 'when only required attributes' do # rubocop:disable RSpec/ExampleLength
      request.usage          = nil
      request.remote_ip      = nil
      request.customer_email = nil
      request.customer_phone = nil
      request.birth_date     = nil
      expect { request.build_document }.to_not raise_error
    end
  end

  include_examples 'address info attributes examples'
  include_examples 'base request examples'
  include_examples 'customer account attributes examples'
  include_examples 'financial attributes examples'
  include_examples 'payment attributes examples'
end
