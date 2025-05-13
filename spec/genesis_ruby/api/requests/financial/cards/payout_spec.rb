RSpec.describe GenesisRuby::Api::Requests::Financial::Cards::Payout do
  let(:test_required_fields) do
    %i[
      transaction_id
      amount
      currency
      card_holder
      card_number
      expiration_month
      expiration_year
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

    request.transaction_id     = Faker::Internet.uuid
    request.amount             = Faker::Number.decimal(l_digits: 2, r_digits: 2)
    request.currency           = 'EUR'
    request.usage              = Faker::Lorem.sentence
    request.remote_ip          = Faker::Internet.ip_v4_address
    request.customer_email     = Faker::Internet.email
    request.customer_phone     = Faker::PhoneNumber.cell_phone_in_e164

    # Credit Card Attributes
    request.card_holder      = Faker::Name.name_with_middle
    request.card_number      = Faker::Finance.credit_card
    request.expiration_month = Faker::Date.in_date_period.strftime '%m'
    request.expiration_year  = Faker::Date.in_date_period.strftime '%Y'
    request.cvv              = Faker::Number.positive from: 100, to: 999

    request
  end

  include_examples 'account owner attributes examples'
  include_examples 'address info attributes examples'
  include_examples 'base request examples'
  include_examples 'birth date attributes examples'
  include_examples 'credential on file attributes examples'
  include_examples 'credit card attributes examples'
  include_examples 'crypto attributes examples'
  include_examples 'customer identification attributes examples'
  include_examples 'digital asset type attributes examples'
  include_examples 'document attributes examples'
  include_examples 'dynamic descriptor examples'
  include_examples 'financial attributes examples'
  include_examples 'fx rate attributes examples'
  include_examples 'gaming attributes examples'
  include_examples 'moto attributes examples'
  include_examples 'payment attributes examples'
  include_examples 'purpose of payment attributes examples'
  include_examples 'source of funds attributes examples'
  include_examples 'tokenization attributes examples'
end
