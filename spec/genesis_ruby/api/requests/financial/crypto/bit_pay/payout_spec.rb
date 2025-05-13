RSpec.describe GenesisRuby::Api::Requests::Financial::Crypto::BitPay::Payout do
  let(:skip_customer_phone) { true }
  let(:test_required_fields) do
    %i[transaction_id amount currency crypto_address crypto_wallet_provider]
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

    request.transaction_id         = Faker::Internet.uuid
    request.amount                 = Faker::Number.decimal l_digits: 2, r_digits: 2
    request.currency               = 'USD'
    request.usage                  = Faker::Lorem.sentence
    request.remote_ip              = Faker::Internet.ip_v4_address
    request.customer_email         = Faker::Internet.email
    request.return_success_url     = Faker::Internet.url
    request.return_failure_url     = Faker::Internet.url
    request.notification_url       = Faker::Internet.url
    request.crypto_address         = Faker::Internet.uuid
    request.crypto_wallet_provider = Faker::Internet.uuid

    request
  end

  describe 'when crypto_address' do
    it 'with valid value' do
      request.crypto_address = value = Faker::Internet.uuid

      expect(request.build_document).to include "<crypto_address>#{value}</crypto_address>"
    end
  end

  describe 'when crypto_wallet_provider' do
    it 'with valid value' do
      request.crypto_wallet_provider = value = Faker::Internet.uuid

      expect(request.build_document).to include "<crypto_wallet_provider>#{value}</crypto_wallet_provider>"
    end
  end

  include_examples 'address info attributes examples'
  include_examples 'async attributes examples'
  include_examples 'base request examples'
  include_examples 'financial attributes examples'
  include_examples 'notification attributes examples'
  include_examples 'payment attributes examples'
end
