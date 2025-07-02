# frozen_string_literal: true

RSpec.shared_examples 'threeds v2 common attributes examples' do
  describe 'when method attributes' do
    describe 'when callback url' do
      it 'without threeds_v2_method_callback_url' do
        expect(request.build_document).to_not include 'callback_url'
      end

      it 'with threeds_v2_method_callback_url' do
        request.threeds_v2_method_callback_url = url = Faker::Internet.url

        expect(request.build_document).to include "<callback_url>#{url}</callback_url>"
      end
    end
  end

  describe 'when control attributes' do
    describe 'when device type' do
      it 'without threeds_v2_control_device_type' do
        expect(request.build_document).to_not include 'threeds_v2_control_device_type'
      end

      it 'when browser threeds_v2_control_device_type without field dependencies' do
        request.threeds_v2_control_device_type = GenesisRuby::Api::Constants::Transactions::Parameters::Threeds::
            Version2::Control::DeviceTypes::BROWSER

        expect { request.build_document }.to raise_error GenesisRuby::ParameterError
      end

      it 'when browser threeds_v2_control_device_type with field dependencies' do # rubocop:disable RSpec/ExampleLength
        request.threeds_v2_control_device_type = type = GenesisRuby::Api::Constants::Transactions::Parameters::
            Threeds::Version2::Control::DeviceTypes::BROWSER

        request.threeds_v2_browser_accept_header    = '*/*'
        request.threeds_v2_browser_java_enabled     = false
        request.threeds_v2_browser_language         = 'en-GB'
        request.threeds_v2_browser_color_depth      = 48
        request.threeds_v2_browser_screen_height    = 400
        request.threeds_v2_browser_screen_width     = 400
        request.threeds_v2_browser_time_zone_offset = '+0'
        request.threeds_v2_browser_user_agent       = Faker::Internet.user_agent

        expect(request.build_document).to include "<device_type>#{type}</device_type>"
      end

      it 'when application threeds_control_device_type without filed dependencies' do
        request.threeds_v2_control_device_type = GenesisRuby::Api::Constants::Transactions::Parameters::Threeds::
            Version2::Control::DeviceTypes::APPLICATION

        expect { request.build_document }.to raise_error GenesisRuby::ParameterError
      end

      it 'when application threeds_v2_control_device_type with field_dependencies' do # rubocop:disable RSpec/ExampleLength
        request.threeds_v2_control_device_type = type = GenesisRuby::Api::Constants::Transactions::Parameters::
            Threeds::Version2::Control::DeviceTypes::APPLICATION

        request.threeds_v2_sdk_interface                 = 'native'
        request.threeds_v2_sdk_ui_types                  = 'text'
        request.threeds_v2_sdk_application_id            = Faker::Internet.uuid
        request.threeds_v2_sdk_encrypted_data            = Faker::Internet.uuid
        request.threeds_v2_sdk_ephemeral_public_key_pair = Faker::Internet.uuid
        request.threeds_v2_sdk_max_timeout               = 15
        request.threeds_v2_sdk_reference_number          = '1234'

        expect(request.build_document).to include "<device_type>#{type}</device_type>"
      end
    end

    describe 'when challenge window size' do
      it 'without threeds_v2_control_challenge_window_size' do
        expect(request.build_document).to_not include 'challenge_window_size'
      end

      it 'with threeds_v2_control_challenge_window_size' do
        request.threeds_v2_control_challenge_window_size = window_size = GenesisRuby::Api::Constants::Transactions::
            Parameters::Threeds::Version2::Control::ChallengeWindowSizes.all.sample

        expect(request.build_document).to include "<challenge_window_size>#{window_size}</challenge_window_size>"
      end
    end

    describe 'when challenge indicator' do
      it 'without threeds_v2_control_challenge_indicator' do
        expect(request.build_document).to_not include 'challenge_indicator'
      end

      it 'with threeds_v2_control_challenge_indicator' do
        request.threeds_v2_control_challenge_indicator = indicator = GenesisRuby::Api::Constants::Transactions::
            Parameters::Threeds::Version2::Control::ChallengeIndicators.all.sample

        expect(request.build_document).to include "<challenge_indicator>#{indicator}</challenge_indicator>"
      end
    end
  end

  describe 'when browser attributes' do
    describe 'when accept header' do
      it 'without threeds_v2_browser_accept_header' do
        expect(request.build_document).to_not include 'accept_header'
      end

      it 'with threeds_v2_browser_accept_header' do
        request.threeds_v2_browser_accept_header = header = '*/*'

        expect(request.build_document).to include "<accept_header>#{header}</accept_header>"
      end
    end

    describe 'when java enabled' do
      it 'without threeds_v2_browser_java_enabled' do
        expect(request.build_document).to_not include 'java_enabled'
      end

      it 'with threeds_v2_browser_java_enabled' do
        request.threeds_v2_browser_java_enabled = true

        expect(request.build_document).to include '<java_enabled>true</java_enabled>'
      end
    end

    describe 'when language' do
      it 'without threeds_v2_browser_language' do
        expect(request.build_document).to_not include 'browser_language'
      end

      it 'with threeds_v2_browser_language' do
        request.threeds_v2_browser_language = language = 'en_GB'

        expect(request.build_document).to include "<language>#{language}</language>"
      end
    end

    describe 'when color depth' do
      it 'without threeds_v2_browser_color_depth' do
        expect(request.build_document).to_not include 'color_depth'
      end

      it 'with threeds_v2_browser_color_depth' do
        request.threeds_v2_browser_color_depth = color_depth = GenesisRuby::Api::Constants::Transactions::Parameters::
            Threeds::Version2::Browser::ColorDepths.all.sample

        expect(request.build_document).to include "<color_depth>#{color_depth}</color_depth>"
      end
    end

    describe 'when screen height' do
      it 'without threeds_v2_browser_screen_height' do
        expect(request.build_document).to_not include 'screen_height'
      end

      it 'with threeds_v2_browser_screen_height' do
        request.threeds_v2_browser_screen_height = screen_height = Faker::Number.positive from: 100, to: 4000

        expect(request.build_document).to include "<screen_height>#{screen_height}</screen_height>"
      end
    end

    describe 'when screen width' do
      it 'without threeds_v2_browser_screen_width' do
        expect(request.build_document).to_not include 'screen_width'
      end

      it 'with threeds_v2_browser_screen_width' do
        request.threeds_v2_browser_screen_width = screen_width = Faker::Number.positive from: 100, to: 4000

        expect(request.build_document).to include "<screen_width>#{screen_width}</screen_width>"
      end
    end

    describe 'when time zone offset' do
      it 'without threeds_v2_browser_time_zone_offset' do
        expect(request.build_document).to_not include 'time_zone_offset'
      end

      it 'with threeds_v2_browser_time_zone_offset' do
        request.threeds_v2_browser_time_zone_offset = offset = '+0'

        expect(request.build_document).to include "<time_zone_offset>#{offset}</time_zone_offset>"
      end
    end

    describe 'when user agent' do
      it 'without threeds_v2_browser_user_agent' do
        expect(request.build_document).to_not include 'user_agent'
      end

      it 'with threeds_v2_browser_user_agent' do
        request.threeds_v2_browser_user_agent = user_agent = Faker::Internet.user_agent

        expect(request.build_document).to include "<user_agent>#{user_agent}</user_agent>"
      end
    end
  end

  describe 'when sdk attributes' do
    describe 'when interface' do
      it 'without threeds_v2_sdk_interface' do
        expect(request.build_document).to_not include 'inteface'
      end

      it 'with threeds_v2_sdk_interface' do
        request.threeds_v2_sdk_interface = interface = GenesisRuby::Api::Constants::Transactions::Parameters::Threeds::
            Version2::Sdk::Interfaces.all.sample

        expect(request.build_document).to include "<interface>#{interface}</interface>"
      end
    end

    describe 'when ui types' do
      it 'without threeds_v2_sdk_ui_types' do
        expect(request.build_document).to_not include 'ui_types'
      end

      it 'with threeds_v2_sdk_ui_types' do
        request.threeds_v2_sdk_ui_types = type = GenesisRuby::Api::Constants::Transactions::Parameters::Threeds::
            Version2::Sdk::UiTypes.all.sample

        expect(request.build_document).to include "<ui_type>#{type}</ui_type>"
      end
    end

    describe 'when application id' do
      it 'without threeds_v2_sdk_application_id' do
        expect(request.build_document).to_not include 'application_id'
      end

      it 'with threeds_v2_sdk_application_id' do
        request.threeds_v2_sdk_application_id = identifier = Faker::Number.positive

        expect(request.build_document).to include "<application_id>#{identifier}</application_id>"
      end
    end

    describe 'when encrypted data' do
      it 'without threeds_v2_sdk_encrypted_data' do
        expect(request.build_document).to_not include 'encrypted_data'
      end

      it 'with threeds_v2_sdk_encrypted_data' do
        request.threeds_v2_sdk_encrypted_data = data = Faker::Internet.uuid

        expect(request.build_document).to include "<encrypted_data>#{data}</encrypted_data>"
      end
    end

    describe 'when ephemeral public key pair' do
      it 'without threeds_v2_sdk_ephemeral_public_key_pair' do
        expect(request.build_document).to_not include 'ephemeral_public_key_pair'
      end

      it 'with threeds_v2_sdk_ephemeral_public_key_pair' do
        request.threeds_v2_sdk_ephemeral_public_key_pair = key = Faker::Internet.uuid

        expect(request.build_document).to include "<ephemeral_public_key_pair>#{key}</ephemeral_public_key_pair>"
      end
    end

    describe 'when max timeout' do
      it 'without threeds_v2_sdk_max_timeout' do
        expect(request.build_document).to_not include 'max_timeout'
      end

      it 'with threeds_v2_sdk_max_timeout' do
        request.threeds_v2_sdk_max_timeout = timeout = Faker::Number.positive(from: 5).to_i

        expect(request.build_document).to include "<max_timeout>#{timeout}</max_timeout>"
      end
    end

    describe 'when reference number' do
      it 'without threeds_v2_sdk_reference_number' do
        expect(request.build_document).to_not include 'reference_number'
      end

      it 'with threeds_v2_sdk_reference_number' do
        request.threeds_v2_sdk_reference_number = reference = Faker::Number.positive

        expect(request.build_document).to include "<reference_number>#{reference}</reference_number>"
      end
    end
  end

  describe 'when purchase attributes' do
    describe 'when category' do
      it 'without threeds_v2_purchase_category' do
        expect(request.build_document).to_not include 'category'
      end

      it 'with threeds_v2_purchase_category' do
        request.threeds_v2_purchase_category = category = GenesisRuby::Api::Constants::Transactions::Parameters::
            Threeds::Version2::Purchase::Categories.all.sample

        expect(request.build_document).to include "<category>#{category}</category>"
      end
    end
  end

  describe 'when recurring attributes' do
    describe 'when expiration date' do
      it 'without threeds_v2_recurring_expiration_date' do
        expect(request.build_document).to_not include 'expiration_date'
      end

      it 'with threeds_v2_recurring_expiration_date' do
        request.threeds_v2_recurring_expiration_date = date = Faker::Date.in_date_period.strftime('%d-%m-%Y')

        expect(request.build_document).to include "<expiration_date>#{date}</expiration_date>"
      end
    end

    describe 'when frequency' do
      it 'without threeds_v2_recurring_frequency' do
        expect(request.build_document).to_not include 'frequency'
      end

      it 'with threeds_v2_recurring_frequency' do
        request.threeds_v2_recurring_frequency = frequency = 30

        expect(request.build_document).to include "<frequency>#{frequency}</frequency>"
      end
    end
  end

  describe 'when merchant risk attributes' do
    describe 'when shipping indicator' do
      it 'without threeds_v2_merchant_risk_shipping_indicator' do
        expect(request.build_document).to_not include 'shipping_indicator'
      end

      it 'with threeds_v2_merchant_risk_shipping_indicator' do
        request.threeds_v2_merchant_risk_shipping_indicator = indicator = GenesisRuby::Api::Constants::Transactions::
            Parameters::Threeds::Version2::MerchantRisk::ShippingIndicators.all.sample

        expect(request.build_document).to include "<shipping_indicator>#{indicator}</shipping_indicator>"
      end
    end

    describe 'when delivery timeframe' do
      it 'without threeds_v2_merchant_risk_delivery_timeframe' do
        expect(request.build_document).to_not include 'delivery_timeframe'
      end

      it 'with threeds_v2_merchant_risk_delivery_timeframe' do
        request.threeds_v2_merchant_risk_delivery_timeframe = timeframe = GenesisRuby::Api::Constants::Transactions::
            Parameters::Threeds::Version2::MerchantRisk::DeliveryTimeframes.all.sample

        expect(request.build_document).to include "<delivery_timeframe>#{timeframe}</delivery_timeframe>"
      end
    end

    describe 'when reorder items indicator' do
      it 'without threeds_v2_merchant_risk_reorder_items_indicator' do
        expect(request.build_document).to_not include 'reorder_items_indicator'
      end

      it 'with threeds_v2_merchant_risk_reorder_items_indicator' do
        request.threeds_v2_merchant_risk_reorder_items_indicator = indicator = GenesisRuby::Api::Constants::
            Transactions::Parameters::Threeds::Version2::MerchantRisk::ReorderItemIndicators.all.sample

        expect(request.build_document).to include "<reorder_items_indicator>#{indicator}</reorder_items_indicator>"
      end
    end

    describe 'when pre order purchase indicator' do
      it 'without threeds_v2_merchant_risk_pre_order_purchase_indicator' do
        expect(request.build_document).to_not include 'pre_order_purchase_indicator'
      end

      it 'with threeds_v2_merchant_risk_pre_order_purchase_indicator' do
        request.threeds_v2_merchant_risk_pre_order_purchase_indicator = indicator = GenesisRuby::Api::Constants::
            Transactions::Parameters::Threeds::Version2::MerchantRisk::PreOrderPurchaseIndicators.all.sample

        expect(
          request.build_document
        ).to include "<pre_order_purchase_indicator>#{indicator}</pre_order_purchase_indicator>"
      end
    end

    describe 'when pre order date' do
      it 'without threeds_v2_merchant_risk_pre_order_date' do
        expect(request.build_document).to_not include 'pre_order_date'
      end

      it 'with threeds_v2_merchant_risk_pre_order_date' do
        request.threeds_v2_merchant_risk_pre_order_date = date = Faker::Date.in_date_period.strftime('%d-%m-%Y')

        expect(request.build_document).to include "<pre_order_date>#{date}</pre_order_date>"
      end
    end

    describe 'when gift card' do
      it 'without threeds_v2_merchant_risk_gift_card' do
        expect(request.build_document).to_not include 'gift_card'
      end

      it 'with threeds_v2_merchant_risk_gift_card' do
        request.threeds_v2_merchant_risk_gift_card = true

        expect(request.build_document).to include '<gift_card>true</gift_card>'
      end
    end

    describe 'when gift card count' do
      it 'without threeds_v2_merchant_risk_gift_card_count' do
        expect(request.build_document).to_not include 'gift_card_count'
      end

      it 'with threeds_v2_merchant_risk_gift_card_count' do
        request.threeds_v2_merchant_risk_gift_card_count = count = Faker::Number.positive.to_i

        expect(request.build_document).to include "<gift_card_count>#{count}</gift_card_count>"
      end
    end
  end

  describe 'when card holder account' do
    describe 'when creation date' do
      it 'without threeds_v2_card_holder_account_creation_date' do
        expect(request.build_document).to_not include 'creation_date'
      end

      it 'with threeds_v2_card_holder_account_creation_date' do
        request.threeds_v2_card_holder_account_creation_date = date = Faker::Date.backward(days: 1).strftime('%d-%m-%Y')

        expect(request.build_document).to include "<creation_date>#{date}</creation_date>"
      end
    end

    describe 'when update indicator' do
      it 'without threeds_v2_card_holder_account_update_indicator' do
        expect(request.build_document).to_not include 'update_indicator'
      end

      it 'with threeds_v2_card_holder_account_update_indicator' do
        request.threeds_v2_card_holder_account_update_indicator = indicator = GenesisRuby::Api::Constants::
            Transactions::Parameters::Threeds::Version2::CardHolderAccount::UpdateIndicators.all.sample

        expect(request.build_document).to include "<update_indicator>#{indicator}</update_indicator>"
      end
    end

    describe 'when last change date' do
      it 'without threeds_v2_card_holder_account_last_change_date' do
        expect(request.build_document).to_not include 'last_change_date'
      end

      it 'with threeds_v2_card_holder_account_last_change_date' do
        request.threeds_v2_card_holder_account_last_change_date = date =
          Faker::Date.backward(days: 1).strftime('%d-%m-%Y')

        expect(request.build_document).to include "<last_change_date>#{date}</last_change_date>"
      end
    end

    describe 'when password change indicator' do
      it 'without threeds_v2_card_holder_account_password_change_indicator' do
        expect(request.build_document).to_not include 'password_change_indicator'
      end

      it 'with threeds_v2_card_holder_account_password_change_indicator' do
        request.threeds_v2_card_holder_account_password_change_indicator = indicator = GenesisRuby::Api::Constants::
            Transactions::Parameters::Threeds::Version2::CardHolderAccount::PasswordChangeIndicators.all.sample

        expect(request.build_document).to include "<password_change_indicator>#{indicator}</password_change_indicator>"
      end
    end

    describe 'when password change date' do
      it 'without threeds_v2_card_holder_account_password_change_date' do
        expect(request.build_document).to_not include 'password_change_indicator'
      end

      it 'with threeds_v2_card_holder_account_password_change_date' do
        request.threeds_v2_card_holder_account_password_change_date = date =
          Faker::Date.backward(days: 1).strftime('%d-%m-%Y')

        expect(request.build_document).to include "<password_change_date>#{date}</password_change_date>"
      end
    end

    describe 'when shipping address usage indicator' do
      it 'without threeds_v2_card_holder_account_shipping_address_usage_indicator' do
        expect(request.build_document).to_not include 'shipping_address_usage_indicator'
      end

      it 'with threeds_v2_card_holder_account_shipping_address_usage_indicator' do
        request.threeds_v2_card_holder_account_shipping_address_usage_indicator = indicator = GenesisRuby::Api::
            Constants::Transactions::Parameters::Threeds::Version2::CardHolderAccount::
            ShippingAddressUsageIndicators.all.sample

        expect(request.build_document)
          .to include "<shipping_address_usage_indicator>#{indicator}</shipping_address_usage_indicator>"
      end
    end

    describe 'when shipping address date first used' do
      it 'without threeds_v2_card_holder_account_shipping_address_date_first_used' do
        expect(request.build_document).to_not include 'shipping_address_date_first_used'
      end

      it 'with threeds_v2_card_holder_account_shipping_address_date_first_used' do
        request.threeds_v2_card_holder_account_shipping_address_date_first_used = date =
          Faker::Date.backward(days: 1).strftime('%d-%m-%Y')

        expect(
          request.build_document
        ).to include "<shipping_address_date_first_used>#{date}</shipping_address_date_first_used>"
      end
    end

    describe 'when transaction activity last 24 hours' do
      it 'without threeds_v2_card_holder_account_transactions_activity_last24_hours' do
        expect(request.build_document).to_not include 'transactions_activity_last_24_hours'
      end

      it 'with threeds_v2_card_holder_account_transactions_activity_last24_hours' do
        request.threeds_v2_card_holder_account_transactions_activity_last24_hours = count = Faker::Number.positive.to_i

        expect(
          request.build_document
        ).to include "<transactions_activity_last_24_hours>#{count}</transactions_activity_last_24_hours>"
      end
    end

    describe 'when transaction activity previous year' do
      it 'without threeds_v2_card_holder_account_transactions_activity_previous_year' do
        expect(request.build_document).to_not include 'transactions_activity_previous_year'
      end

      it 'with threeds_v2_card_holder_account_transactions_activity_previous_year' do
        request.threeds_v2_card_holder_account_transactions_activity_previous_year = count = Faker::Number.positive.to_i

        expect(
          request.build_document
        ).to include "<transactions_activity_previous_year>#{count}</transactions_activity_previous_year>"
      end
    end

    describe 'when provision attempts last 24 hours' do
      it 'without threeds_v2_card_holder_account_provision_attempts_last24_hours' do
        expect(request.build_document).to_not include 'provision_attempt_last_24_hours'
      end

      it 'with threeds_v2_card_holder_account_provision_attempts_last24_hours' do
        request.threeds_v2_card_holder_account_provision_attempts_last24_hours = count = Faker::Number.positive.to_i

        expect(
          request.build_document
        ).to include "<provision_attempts_last_24_hours>#{count}</provision_attempts_last_24_hours>"
      end
    end

    describe 'when purchases count last 6 months' do
      it 'without threeds_v2_card_holder_account_purchases_count_last6_months' do
        expect(request.build_document).to_not include 'purchases_count_last_6_months'
      end

      it 'with threeds_v2_card_holder_account_purchases_count_last6_months' do
        request.threeds_v2_card_holder_account_purchases_count_last6_months = count = Faker::Number.positive.to_i

        expect(
          request.build_document
        ).to include "<purchases_count_last_6_months>#{count}</purchases_count_last_6_months>"
      end
    end

    describe 'when registration indicator' do
      it 'without threeds_v2_card_holder_account_registration_indicator' do
        expect(request.build_document).to_not include 'registration_indicator'
      end

      it 'with threeds_v2_card_holder_account_registration_indicator' do
        request.threeds_v2_card_holder_account_registration_indicator = indicator = GenesisRuby::Api::
            Constants::Transactions::Parameters::Threeds::Version2::CardHolderAccount::
            RegistrationIndicators.all.sample

        expect(request.build_document)
          .to include "<registration_indicator>#{indicator}</registration_indicator>"
      end
    end

    describe 'when registration date' do
      it 'without threeds_v2_card_holder_account_registration_date' do
        expect(request.build_document).to_not include 'registration_date'
      end

      it 'with threeds_v2_card_holder_account_registration_date' do
        request.threeds_v2_card_holder_account_registration_date = date =
          Faker::Date.backward(days: 1).strftime('%d-%m-%Y')

        expect(
          request.build_document
        ).to include "<registration_date>#{date}</registration_date>"
      end
    end
  end
end
