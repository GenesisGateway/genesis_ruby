RSpec.describe GenesisRuby::Api::Requests::Financial::Cards::Sale3d do
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
      threeds_v2_control_device_type
      threeds_v2_control_challenge_window_size
      threeds_v2_control_challenge_indicator
      threeds_v2_purchase_category
      threeds_v2_merchant_risk_shipping_indicator
      threeds_v2_merchant_risk_delivery_timeframe
      threeds_v2_merchant_risk_reorder_items_indicator
      threeds_v2_merchant_risk_pre_order_purchase_indicator
      threeds_v2_merchant_risk_gift_card
      threeds_v2_card_holder_account_update_indicator
      threeds_v2_card_holder_account_password_change_indicator
      threeds_v2_card_holder_account_shipping_address_usage_indicator
      threeds_v2_card_holder_account_suspicious_activity_indicator
      threeds_v2_card_holder_account_registration_indicator
      threeds_v2_browser_color_depth
      threeds_v2_browser_java_enabled
      threeds_v2_sdk_interface
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
  include_examples 'async attributes examples'
  include_examples 'base request examples'
  include_examples 'business attributes examples'
  include_examples 'card holder date attributes examples'
  include_examples 'credential on file attributes examples'
  include_examples 'credit card attributes examples'
  include_examples 'crypto attributes examples'
  include_examples 'document attributes examples'
  include_examples 'dynamic descriptor examples'
  include_examples 'financial attributes examples'
  include_examples 'funding attributes examples'
  include_examples 'fx rate attributes examples'
  include_examples 'gaming attributes examples'
  include_examples 'installment attributes examples'
  include_examples 'managed recurring examples'
  include_examples 'moto attributes examples'
  include_examples 'mpi attributes examples'
  include_examples 'notification attributes examples'
  include_examples 'payment attributes examples'
  include_examples 'recurring category examples'
  include_examples 'recurring type initial examples'
  include_examples 'risk attributes examples'
  include_examples 'sca attributes examples'
  include_examples 'scheme tokenized attributes examples'
  include_examples 'threeds v2 common attributes examples'
  include_examples 'tokenization attributes examples'
  include_examples 'travel data attributes examples'
  include_examples 'ucof attributes examples'
end
