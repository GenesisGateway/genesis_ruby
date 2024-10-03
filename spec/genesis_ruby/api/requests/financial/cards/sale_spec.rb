RSpec.describe GenesisRuby::Api::Requests::Financial::Cards::Sale do
  let(:test_required_fields) { %i[transaction_id amount currency] }
  let(:test_required_field_values) do
    %i[
      currency
      recurring_type
      managed_recurring_mode
      managed_recurring_interval
      managed_recurring_mode
      managed_recurring_interval
      managed_recurring_payment_type
      managed_recurring_amount_type
      managed_recurring_frequency
      managed_recurring_validated
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

  include_examples 'address info attributes examples'
  include_examples 'base request examples'
  include_examples 'business attributes examples'
  include_examples 'credit card attributes examples'
  include_examples 'crypto attributes examples'
  include_examples 'document attributes examples'
  include_examples 'dynamic descriptor examples'
  include_examples 'fx rate attributes examples'
  include_examples 'gaming attributes examples'
  include_examples 'moto attributes examples'
  include_examples 'payment attributes examples'
  include_examples 'recurring category examples'
  include_examples 'recurring type examples'
  include_examples 'reference attributes examples'
  include_examples 'risk attributes examples'
  include_examples 'sca attributes examples'
  include_examples 'tokenization attributes examples'
  include_examples 'account owner attributes examples'
  include_examples 'managed recurring examples'
  include_examples 'travel data attributes examples'
end
