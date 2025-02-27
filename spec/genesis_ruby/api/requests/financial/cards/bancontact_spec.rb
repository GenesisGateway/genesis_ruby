RSpec.describe GenesisRuby::Api::Requests::Financial::Cards::Bancontact do # rubocop:disable RSpec/MultipleMemoizedHelpers
  let(:test_required_fields) do
    %i[transaction_id
       billing_country
       amount
       currency]
  end
  let(:test_required_field_values) { %i[currency billing_country] }
  let(:skip_customer_phone) { true }
  let(:skip_customer_email) { true }

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
    request.remote_ip          = Faker::Internet.ip_v4_address
    request.usage              = Faker::Lorem.sentence
    request.return_success_url = Faker::Internet.url
    request.return_failure_url = Faker::Internet.url
    request.amount             = 100
    request.currency           = 'EUR'
    request.billing_country    = 'BE'

    request
  end

  describe 'when invalid values' do # rubocop:disable RSpec/MultipleMemoizedHelpers
    it 'with currency' do
      request.currency = 'USD'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with billing country' do
      request.billing_country = 'BG'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  include_examples 'base request examples'
  include_examples 'financial attributes examples'
  include_examples 'financial structure examples'
  include_examples 'address info attributes examples'
  include_examples 'async attributes examples'
  include_examples 'payment attributes examples'
end
