RSpec.describe GenesisRuby::Api::Requests::Financial::Crypto::BitPay::Sale do
  let(:skip_customer_phone) { true }
  let(:test_required_fields) do
    %i[transaction_id amount currency customer_email]
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

    request.transaction_id = Faker::Internet.uuid
    request.amount         = Faker::Number.decimal l_digits: 2, r_digits: 2
    request.currency       = 'USD'
    request.usage          = Faker::Lorem.sentence
    request.remote_ip      = Faker::Internet.ip_v4_address
    request.customer_email = Faker::Internet.email
    request.return_url     = Faker::Internet.url

    request
  end

  describe 'when return_url' do
    it 'with valid value' do
      request.return_url = url = Faker::Internet.url

      expect(request.build_document).to include "<return_url>#{url}</return_url>"
    end

    it 'with invalid value' do
      expect { request.return_url = 'invalid_value' }.to raise_error GenesisRuby::ParameterError
    end
  end

  include_examples 'address info attributes examples'
  include_examples 'base request examples'
  include_examples 'financial attributes examples'
  include_examples 'payment attributes examples'
end
