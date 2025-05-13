RSpec.describe GenesisRuby::Api::Requests::Financial::Vouchers::Neosurf do
  let(:test_required_fields) { %i[transaction_id amount currency billing_country] }
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
    request.currency           = 'EUR'
    request.usage              = Faker::Lorem.sentence
    request.remote_ip          = Faker::Internet.ip_v6_address
    request.voucher_number     = Faker::Lorem.characters(number: 10)
    request.return_success_url = Faker::Internet.url
    request.return_failure_url = Faker::Internet.url
    request.billing_country    = 'AT'

    request
  end

  describe 'when voucher_number' do
    it 'without value' do
      expect { request.voucher_number = nil }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'with valid value' do
      request.voucher_number = value = Faker::Lorem.characters(number: 10)

      expect(request.build_document).to include "<voucher_number>#{value}</voucher_number>"
    end

    it 'with invalid value' do
      expect { request.voucher_number = Faker::Lorem.characters(number: 11) }.to raise_error(
        GenesisRuby::InvalidArgumentError
      )
    end
  end

  describe 'when billing_country' do
    it 'with invalid value' do
      request.billing_country = 'US'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  describe 'when currency' do
    it 'with invalid value' do
      request.currency = 'GHS'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  include_examples 'address info attributes examples'
  include_examples 'async attributes examples'
  include_examples 'base request examples'
  include_examples 'financial attributes examples'
  include_examples 'payment attributes examples'
end
