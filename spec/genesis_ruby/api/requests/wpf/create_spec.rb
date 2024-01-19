RSpec.describe GenesisRuby::Api::Requests::Wpf::Create do
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
    request = described_class.new(config)

    request.transaction_id     = Faker::Internet.uuid
    request.amount             = Faker::Number.decimal(l_digits: 2, r_digits: 2)
    request.currency           = 'EUR'
    request.usage              = Faker::Lorem.sentence
    request.description        = Faker::Lorem.sentence

    # Tokenization Attributes
    request.consumer_id        = Faker::Number.positive

    # Async Attributes
    request.notification_url   = Faker::Internet.url
    request.return_success_url = Faker::Internet.url
    request.return_cancel_url  = Faker::Internet.url
    request.return_failure_url = Faker::Internet.url
    request.return_pending_url = Faker::Internet.url

    # Transaction Types
    request.add_transaction_type('sale3d', { bin: '420000' })
    request.add_transaction_type('wechat')

    # Tokenization Attributes
    request.remember_card = true

    # Other
    request.lifetime            = 30
    request.web_payment_form_id = Faker::Number.positive

    request
  end

  include_examples 'recurring category examples'
  include_examples 'dynamic descriptor examples'
  include_examples 'risk attributes examples'
  include_examples 'business attributes examples'
  include_examples 'address info attributes examples'
  include_examples 'base request examples'
  include_examples 'account owner attributes examples'

  it 'has proper structure without threedsv2 parameters' do
    expect(request.build_document).to_not include 'threeds_v2_params'
  end

  it 'has transaction type' do
    expect(request.build_document).to include('<transaction_type name="sale3d">')
  end

  it 'fails with invalid transaction type' do
    expect { request.add_transaction_type('invalid') }.to raise_error GenesisRuby::ParameterError
  end

  it 'fails without parameters' do
    expect { described_class.new(config).build_document }.to raise_error GenesisRuby::InvalidArgumentError
  end

  it 'has locale with ecp endpoint' do
    config.endpoint = GenesisRuby::Api::Constants::Endpoints::ECOMPROCESSING

    request         = described_class.new(config)
    request.locale  = 'BG'

    expect(request.api_config.url).to eq 'https://staging.wpf.e-comprocessing.net:443/bg/wpf'
  end

  it 'has locale with emp endpoint' do
    request.locale = 'IT'

    expect(request.api_config.url).to eq 'https://staging.wpf.emerchantpay.net:443/it/wpf'
  end

  describe 'when 3DSv2 attributes' do
    let(:threeds_request) do
      ## Control Attributes
      request.threeds_v2_control_challenge_window_size = 'full_screen'
      request.threeds_v2_control_challenge_indicator   = 'mandate'

      ## Purchase Attributes
      request.threeds_v2_purchase_category = 'goods'

      ## Recurring
      request.threeds_v2_recurring_expiration_date = '12-12-2024'
      request.threeds_v2_recurring_frequency       = 30

      ## Merchant Risk Attributes
      request.threeds_v2_merchant_risk_shipping_indicator           = 'same_as_billing'
      request.threeds_v2_merchant_risk_delivery_timeframe           = 'electronic'
      request.threeds_v2_merchant_risk_reorder_items_indicator      = 'first_time'
      request.threeds_v2_merchant_risk_pre_order_purchase_indicator = 'merchandise_available'
      request.threeds_v2_merchant_risk_pre_order_date               = '01-01-2024'
      request.threeds_v2_merchant_risk_gift_card                    = false
      request.threeds_v2_merchant_risk_gift_card_count              = 0

      ## Card Holder Account Attributes
      request.threeds_v2_card_holder_account_creation_date                       = '01-01-2023'
      request.threeds_v2_card_holder_account_update_indicator                    = 'current_transaction'
      request.threeds_v2_card_holder_account_last_change_date                    = '01-01-2023'
      request.threeds_v2_card_holder_account_password_change_indicator           = 'no_change'
      request.threeds_v2_card_holder_account_password_change_date                = '01-01-2023'
      request.threeds_v2_card_holder_account_shipping_address_usage_indicator    = 'current_transaction'
      request.threeds_v2_card_holder_account_shipping_address_date_first_used    = '01-01-2023'
      request.threeds_v2_card_holder_account_transactions_activity_last24_hours  = 1
      request.threeds_v2_card_holder_account_transactions_activity_previous_year = 1
      request.threeds_v2_card_holder_account_provision_attempts_last24_hours     = 2
      request.threeds_v2_card_holder_account_purchases_count_last6_months        = 1
      request.threeds_v2_card_holder_account_registration_indicator              = 'guest_checkout'
      request.threeds_v2_card_holder_account_registration_date                   = '01-01-2023'

      request
    end

    it 'with wpf attributes module' do
      expect(
        described_class.include?(GenesisRuby::Api::Mixins::Requests::Financial::Threeds::Version2::WpfAttributes)
      ).to eq(true)
    end

    it 'has threeds_v2_params' do
      expect(threeds_request.build_document).to include '<threeds_v2_params>'
    end

    it 'has control' do
      expect(threeds_request.build_document).to include '<control>'
    end

    it 'has purchase' do
      expect(threeds_request.build_document).to include '<purchase>'
    end

    it 'has recurring' do
      expect(threeds_request.build_document).to include '<recurring>'
    end

    it 'has merchant_risk' do
      expect(threeds_request.build_document).to include '<merchant_risk>'
    end

    it 'has card_holder_account' do
      expect(threeds_request.build_document).to include '<card_holder_account>'
    end
  end

  describe 'when SCA Exemption' do
    let(:exemption) do
      [
        GenesisRuby::Api::Constants::Transactions::Parameters::ScaExemptions::LOW_VALUE,
        GenesisRuby::Api::Constants::Transactions::Parameters::ScaExemptions::LOW_RISK
      ].sample
    end

    it 'with valid value' do
      expect { request.sca_exemption = exemption }.to_not raise_error
    end

    it 'with accessors' do
      request.sca_exemption = exemption

      expect(request.sca_exemption).to eq exemption
    end

    it 'with invalid value' do
      expect do
        request.sca_exemption = GenesisRuby::Api::Constants::Transactions::Parameters::ScaExemptions::CORPORATE_PAYMENT
      end.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'has proper sca_params structure' do
      request.sca_exemption = exemption

      expect(request.build_document).to include '<sca_params>'
    end

    it 'has proper sca_exemption structure' do
      request.sca_exemption = exemption

      expect(request.build_document).to include "<sca_exemption>#{exemption}</sca_exemption>"
    end

    it 'has proper structure without sca_exemption' do
      request.sca_exemption = ''

      expect(request.build_document).to_not include 'sca_params'
    end
  end

  describe 'when SCA Preference' do
    it 'with valid value' do
      request.sca_preference = true

      expect(request.sca_preference).to eq true
    end

    it 'with invalid value' do
      expect { request.sca_preference = 'invalid' }.to raise_error GenesisRuby::InvalidArgumentError
    end

    it 'has sca preference' do
      request.sca_preference = false

      expect(request.build_document).to include '<sca_preference>false</sca_preference>'
    end

    it 'has proper structure without sca preference' do
      request.sca_preference = ''

      expect(request.build_document).to_not include 'sca_preference'
    end
  end
end
