RSpec.describe GenesisRuby::Api::Requests::Financial::Mobile::RussianMobileSale do
  let(:operators) { %w(mtc megafon tele2 beeline) }
  let(:test_required_fields) do
    %i[transaction_id
       usage
       amount
       currency
       operator
       target
       customer_phone
       billing_country]
  end
  let(:test_required_field_values) { %i[currency billing_country operator] }
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
    request.currency           = 'RUB'
    request.usage              = Faker::Lorem.sentence
    request.remote_ip          = Faker::Internet.ip_v4_address
    request.return_success_url = Faker::Internet.url
    request.return_failure_url = Faker::Internet.url
    request.operator           = operators.sample
    request.target             = Faker::Lorem.characters(number: 20)
    request.customer_email     = Faker::Internet.email
    request.customer_phone     = Faker::PhoneNumber.cell_phone_in_e164
    request.billing_country    = 'RU'

    request
  end

  describe 'when validations' do
    it 'with invalid currency' do
      request.currency = 'EUR'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with invalid billing_country' do
      request.billing_country = 'USA'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end

    it 'with invalid operator' do
      request.operator = 'invalid'

      expect { request.build_document }.to raise_error GenesisRuby::ParameterError
    end
  end

  it 'with target' do
    request.target = value = Faker::Lorem.characters(number: 20)

    expect(request.build_document).to include "<target>#{value}</target>"
  end

  it 'with operator' do
    request.operator = value = operators.sample

    expect(request.build_document).to include "<operator>#{value}</operator>"
  end

  include_examples 'address info attributes examples'
  include_examples 'base request examples'
  include_examples 'financial attributes examples'
  include_examples 'payment attributes examples'
end
