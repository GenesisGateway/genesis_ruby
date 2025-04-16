require 'genesis_ruby/api/constants/transactions/parameters/online_banking/iframe_targets'

RSpec.describe GenesisRuby::Api::Requests::Financial::OnlineBankingPayments::TrustlySale do
  let(:test_required_fields) do
    %i[
      transaction_id
      remote_ip
      amount
      currency
      customer_email
      billing_country
      account_id
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

    request.transaction_id            = Faker::Internet.uuid
    request.usage                     = Faker::Lorem.sentence
    request.remote_ip                 = Faker::Internet.ip_v4_address
    request.amount                    = Faker::Number.decimal l_digits: 2, r_digits: 2
    request.currency                  = 'EUR'
    request.customer_email            = Faker::Internet.email
    request.return_success_url        = Faker::Internet.url
    request.return_failure_url        = Faker::Internet.url
    request.return_success_url_target =
      GenesisRuby::Api::Constants::Transactions::Parameters::OnlineBanking::IframeTargets.all.sample
    request.billing_country           = 'AT'
    request.user_id                   = Faker::Number.number(digits: 7)
    request.account_id                = Faker::Number.number(digits: 7)

    request
  end

  describe 'when billing_country' do
    it 'with invalid value' do
      request.billing_country = 'US'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  describe 'when return_success_url_target' do
    it 'with valid value' do
      request.return_success_url_target = return_success_url_target = 'self'

      expect(request.build_document)
        .to include "<return_success_url_target>#{return_success_url_target}</return_success_url_target>"
    end

    it 'with invalid value' do
      expect { request.return_success_url_target = 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
    end
  end

  describe 'when account_id' do
    it 'with account_id' do
      request.account_id = account_id = Faker::Number.number(digits: 7)

      expect(request.build_document).to include "<account_id>#{account_id}</account_id>"
    end
  end

  describe 'when user_id' do
    it 'with user_id' do
      request.user_id = user_id = Faker::Number.number(digits: 7)

      expect(request.build_document).to include "<user_id>#{user_id}</user_id>"
    end
  end

  include_examples 'address info attributes examples'
  include_examples 'async attributes examples'
  include_examples 'base request examples'
  include_examples 'financial attributes examples'
  include_examples 'payment attributes examples'
  include_examples 'birth date attributes examples'
end
