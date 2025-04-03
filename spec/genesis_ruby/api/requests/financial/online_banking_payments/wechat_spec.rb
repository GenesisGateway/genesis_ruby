RSpec.describe GenesisRuby::Api::Requests::Financial::OnlineBankingPayments::Wechat do
  let(:test_required_fields) do
    %i[transaction_id
       usage
       amount
       currency
       billing_country]
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
    request.product_code       = Faker::Lorem.word
    request.product_num        = Faker::Lorem.word
    request.product_desc       = Faker::Lorem.word
    request.customer_email     = Faker::Internet.email
    request.customer_phone     = Faker::PhoneNumber.phone_number
    request.billing_country    = Faker::Address.country_code

    request
  end

  it 'when return_success_url without value' do # rubocop:disable RSpec/ExampleLength
    request                    = described_class.new config
    request.transaction_id     = Faker::Internet.uuid
    request.amount             = Faker::Number.decimal l_digits: 2, r_digits: 2
    request.currency           = 'EUR'
    request.return_failure_url = Faker::Internet.url

    expect { request.build_document }.to raise_error GenesisRuby::ParameterError
  end

  it 'when return_failure_url without value' do # rubocop:disable RSpec/ExampleLength
    request                    = described_class.new config
    request.transaction_id     = Faker::Internet.uuid
    request.amount             = Faker::Number.decimal l_digits: 2, r_digits: 2
    request.currency           = 'EUR'
    request.return_success_url = Faker::Internet.url

    expect { request.build_document }.to raise_error GenesisRuby::ParameterError
  end

  it 'with product code' do
    request.product_code = value = Faker::Lorem.word

    expect(request.build_document).to include "<product_code>#{value}</product_code>"
  end

  it 'with product num' do
    request.product_num = value = Faker::Lorem.word

    expect(request.build_document).to include "<product_num>#{value}</product_num>"
  end

  it 'with product desc' do
    request.product_desc = value = Faker::Lorem.word

    expect(request.build_document).to include "<product_desc>#{value}</product_desc>"
  end

  include_examples 'address info attributes examples'
  include_examples 'async attributes examples'
  include_examples 'payment attributes examples'
  include_examples 'base request examples'
  include_examples 'financial attributes examples'
end
