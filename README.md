
Genesis Ruby
========
[![Gem Version](https://badge.fury.io/rb/genesis_ruby.svg)](https://badge.fury.io/rb/genesis_ruby)
[![Software License](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](LICENSE)

Ruby Client for Genesis Payment Processing Gateway

Overview
--------

Client Library for processing payments through Genesis Payment Processing Gateway. Its highly recommended to checkout "Genesis Payment Gateway API Documentation" first, in order to get an overview of Genesis's Payment Gateway API and functionality.

## Requirements

* Ruby version 2.7 or newer
* [net-http](https://rubygems.org/gems/net-http) 0.3.2 or newer
* [nokogiri](https://rubygems.org/gems/nokogiri) 1.14 or newer

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'genesis_ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install genesis_ruby

## Getting Started

### Configuration
```ruby
configuration             = GenesisRuby::Configuration.new
configuration.username    = '<YOUR USERNAME>'
configuration.password    = '<YOUR PASSWORD>'
configuration.token       = '<YOUR TOKEN>'
configuration.environment = GenesisRuby::Api::Constants::Environments::STAGING   # Support alias strings: 'test', 'testing', 'staging', 'live', 'prod', 'production'
configuration.endpoint    = GenesisRuby::Api::Constants::Endpoints::EMERCHANTPAY # Support alias strings: 'emp', 'emerchantpay', 'ecp', 'ecomprocessing', 'e-comprocessing'
```

### Web Payment Form 
```ruby
require 'genesis_ruby'

begin
  genesis = GenesisRuby::Genesis.for(config: configuration, request: GenesisRuby::Api::Requests::Wpf::Create) do |request|
    # Common Attributes
    request.transaction_id     = '12345-67890'
    request.amount             = '0.99'
    request.currency           = 'EUR'
    request.usage              = 'Example usage'
    request.description        = 'You are about to complete you purchase'
    request.customer_email     = 'travis@example.com'
    request.customer_phone     = '+1987987987987'
    request.notification_url   = 'https://www.example.com/notification'
    request.return_success_url = 'https://www.example.com/success'
    request.return_cancel_url  = 'https://www.example.com/failure'
    request.return_failure_url = 'https://www.example.com/cancel.html'
    request.return_pending_url = 'https://www.example.com/payment-pending.html'

    # Transaction Types
    request.add_transaction_type('authorize3d')
    # Transaction Type with Customer Attribute 
    request.add_transaction_type('sale3d', { bin: '420000' })
    # Transaction Type with Recurring V2
    request.add_transaction_type('sale3d', { recurring_type: GenesisRuby::Api::Constants::Transactions::Parameters::Recurring::Types::INITIAL })

    # Tokenization Attributes
    request.consumer_id   = '123456789'
    request.remember_card = true

    # Billing Attributes
    request.billing_first_name = 'Travis'
    request.billing_last_name  = 'Pastrana'
    request.billing_address1   = 'Muster Str. 12'
    request.billing_zip_code   = '10178'
    request.billing_city       = 'Los Angeles'
    request.billing_state      = 'CA'
    request.billing_country    = 'US'

    # Shipping Attributes
    request.shipping_first_name = 'Travis'
    request.shipping_last_name  = 'Pastrana'
    request.shipping_address1   = 'Muster Str. 12'
    request.shipping_zip_code   = '10178'
    request.shipping_city       = 'Los Angeles'
    request.shipping_state      = 'CA'
    request.shipping_country    = 'US'

    # Internationalization
    request.locale = 'EN'

    # Other
    request.lifetime            = 30
    request.web_payment_form_id = '987654321'

    # Reminders
    request.pay_later           = true
    request.add_reminder channel: 'email', after: 10
    request.add_reminder channel: 'sms', after: 30
  end.execute
  
  puts genesis.response.response_object

rescue GenesisRuby::Error => error
  puts error.message
end
```

A full list of the Transaction Types and Custom Attributes can be found [here](https://emerchantpay.github.io/gateway-api-docs/?shell#wpf-transaction-types).

### Transactions

```ruby
require 'genesis_ruby'

begin
  genesis = GenesisRuby::Genesis.for(config: configuration, request: GenesisRuby::Api::Requests::Financial::Cards::Sale) do |request|
    # Common Attributes
    request.transaction_id     = '12345-67890'
    request.amount             = '0.99'
    request.currency           = 'EUR'
    request.usage              = 'Example usage'
    request.customer_email     = 'travis@example.com'
    request.customer_phone     = '+1987987987987'

    # Credit Card Attributes
    request.card_holder      = 'Travis Pastrana'
    request.card_number      = '4200000000000000'
    request.expiration_month = '12'
    request.expiration_year  = '2040'
    request.cvv              = '834'

    # Billing Attributes
    request.billing_first_name = 'Travis'
    request.billing_last_name  = 'Pastrana'
    request.billing_address1   = 'Muster Str. 12'
    request.billing_zip_code   = '10178'
    request.billing_city       = 'Los Angeles'
    request.billing_state      = 'CA'
    request.billing_country    = 'US'
  end.execute

  puts genesis.response.response_object

rescue GenesisRuby::Error => error
  puts error.message
end
```

### Smart Router

The Smart Routing API is a higher-level abstraction that allows for simpler and more efficient gateway Processing API integration.
It does not require the terminal token (`configuration.token`). This by itself minimizes the need for complex customer-level manual routing to terminals set up on the gateway platform configuration layer.

By default the Smart Router is disabled. Contact your account manager to use the functionality.

Smart Router global definition for all requests
* GenesisRuby::Configuration
  ```ruby
  configuration.force_smart_routing = true
  ```

* Smart Router definition per request
  ```ruby
  request.use_smart_router = true
  ```

### Example 3DSv2 Request

Sample request including all the conditionally required/optional params for initiating a 3DS transaction with the 3DSv2-Method authentication protocol.

Also, an example is provided for the 3DS-Method-continue API call that will have to be submitted after the 3DS-Method is initiated.
<details>

```ruby
require 'genesis_ruby'

begin
  genesis_3ds_v2 = GenesisRuby::Genesis.for(config: configuration, request: GenesisRuby::Api::Requests::Financial::Cards::Sale3d) do |request|
    # Common Attributes
    request.transaction_id     = '12345-67890'
    request.remote_ip          = '127.0.0.1'
    request.amount             = '0.99'
    request.currency           = 'EUR'
    request.usage              = 'Example usage'
    request.customer_email     = 'travis@example.com'
    request.customer_phone     = '+1987987987987'

    # Credit Card Attributes
    request.card_holder      = 'Travis Pastrana'

    # Test Cases
    request.card_number = '4012000000060085' # Test Case: Synchronous 3DSv2 Request with Frictionless flow
    # request.card_number = '4066330000000004' # Test Case: Asynchronous 3DSv2 Request with 3DS-Method and Frictionless flow
    # request.card_number = '4918190000000002' # Test Case: Asynchronous 3DSv2 Request with Challenge flow
    # request.card_number = '4938730000000001' # Test Case: Asynchronous 3DSv2 Request with 3DS-Method Challenge flow
    # request.card_number = '4901170000000003' # Test Case: Asynchronous 3DSv2 Request with Fallback flow
    # request.card_number = '4901164281364345' # Test Case: Asynchronous 3DSv2 Request with 3DS-Method Fallback flow

    request.expiration_month = '12'
    request.expiration_year  = '2040'
    request.cvv              = '123'

    # Async Attributes
    request.notification_url   = 'https://example.com/notification'
    request.return_success_url = 'https://example.com/success'
    request.return_failure_url = 'https://example.com/failure'

    # Billing Attributes
    request.billing_first_name = 'Travis'
    request.billing_last_name  = 'Pastrana'
    request.billing_address1   = 'Kreisfreie Stadt Berlin'
    request.billing_zip_code   = '10115'
    request.billing_city       = 'Berlin'
    request.billing_country    = 'DE'

    # Threeds V2 Attributes

    ## Method Attributes
    request.threeds_v2_method_callback_url = 'https://www.example.com/threeds/threeds_method/callback'

    ## Control Attributes
    request.threeds_v2_control_device_type           =
            GenesisRuby::Api::Constants::Transactions::Parameters::Threeds::Version2::Control::DeviceTypes::BROWSER
    request.threeds_v2_control_challenge_window_size =
            GenesisRuby::Api::Constants::Transactions::Parameters::Threeds::Version2::Control::ChallengeWindowSizes::FULLSCREEN
    request.threeds_v2_control_challenge_indicator   =
            GenesisRuby::Api::Constants::Transactions::Parameters::Threeds::Version2::Control::ChallengeIndicators::MANDATE

    ## Browser Attributes
    ## When Control Device Type is Browser
    request.threeds_v2_browser_accept_header    = '*/*'
    request.threeds_v2_browser_java_enabled     = true
    request.threeds_v2_browser_language         = 'en-GB'
    request.threeds_v2_browser_color_depth      = 48
    request.threeds_v2_browser_screen_height    = 900
    request.threeds_v2_browser_screen_width     = 1440
    request.threeds_v2_browser_time_zone_offset = '+0'
    request.threeds_v2_browser_user_agent       = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.97 Safari/537.36'

    ## SDK
    ## When Control Device Type is SDK
    request.threeds_v2_sdk_interface                 =
            GenesisRuby::Api::Constants::Transactions::Parameters::Threeds::Version2::Sdk::Interfaces::BOTH
    request.threeds_v2_sdk_ui_types                  =
            GenesisRuby::Api::Constants::Transactions::Parameters::Threeds::Version2::Sdk::UiTypes::TEXT
    request.threeds_v2_sdk_ui_types                  =
            GenesisRuby::Api::Constants::Transactions::Parameters::Threeds::Version2::Sdk::UiTypes::SINGLE_SELECT
    request.threeds_v2_sdk_ui_types                  =
            GenesisRuby::Api::Constants::Transactions::Parameters::Threeds::Version2::Sdk::UiTypes::MULTI_SELECT
    request.threeds_v2_sdk_application_id            = 'fc1650c0-5778-0138-8205-2cbc32a32d65'
    request.threeds_v2_sdk_encrypted_data            = 'encrypted-data-here'
    request.threeds_v2_sdk_ephemeral_public_key_pair = 'public-key-pair'
    request.threeds_v2_sdk_max_timeout               = 10
    request.threeds_v2_sdk_reference_number          = 'sdk-reference-number-her'


    ## Purchase Attributes
    request.threeds_v2_purchase_category =
            GenesisRuby::Api::Constants::Transactions::Parameters::Threeds::Version2::Purchase::Categories::GOODS

    ## Recurring
    request.threeds_v2_recurring_expiration_date = '12-12-2024'
    request.threeds_v2_recurring_frequency       = 30

    ## Merchant Risk Attributes
    request.threeds_v2_merchant_risk_shipping_indicator           =
            GenesisRuby::Api::Constants::Transactions::Parameters::Threeds::Version2::MerchantRisk::ShippingIndicators::SAME_AS_BILLING
    request.threeds_v2_merchant_risk_delivery_timeframe           =
            GenesisRuby::Api::Constants::Transactions::Parameters::Threeds::Version2::MerchantRisk::DeliveryTimeframes::ANOTHER_DAY
    request.threeds_v2_merchant_risk_reorder_items_indicator      =
            GenesisRuby::Api::Constants::Transactions::Parameters::Threeds::Version2::MerchantRisk::ReorderItemIndicators::FIRST_TIME
    request.threeds_v2_merchant_risk_pre_order_purchase_indicator =
            GenesisRuby::Api::Constants::Transactions::Parameters::Threeds::Version2::MerchantRisk::PreOrderPurchaseIndicators::MERCHANDISE_AVAILABLE
    request.threeds_v2_merchant_risk_pre_order_date               = '31-12-2030'
    request.threeds_v2_merchant_risk_gift_card                    = true
    request.threeds_v2_merchant_risk_gift_card_count              = 99

    ## Card Holder Account Attributes
    request.threeds_v2_card_holder_account_creation_date                       = '31-12-2022'
    request.threeds_v2_card_holder_account_update_indicator                    =
            GenesisRuby::Api::Constants::Transactions::Parameters::Threeds::Version2::CardHolderAccount::UpdateIndicators::MORE_THAN_60DAYS
    request.threeds_v2_card_holder_account_last_change_date                    = '31-12-2022'
    request.threeds_v2_card_holder_account_password_change_indicator           =
            GenesisRuby::Api::Constants::Transactions::Parameters::Threeds::Version2::CardHolderAccount::PasswordChangeIndicators::NO_CHANGE
    request.threeds_v2_card_holder_account_password_change_date                = '31-12-2022'
    request.threeds_v2_card_holder_account_shipping_address_usage_indicator    =
            GenesisRuby::Api::Constants::Transactions::Parameters::Threeds::Version2::CardHolderAccount::ShippingAddressUsageIndicators::MORE_THAN_60DAYS
    request.threeds_v2_card_holder_account_shipping_address_date_first_used    = '31-12-2022'
    request.threeds_v2_card_holder_account_transactions_activity_last24_hours  = 2
    request.threeds_v2_card_holder_account_transactions_activity_previous_year = 10
    request.threeds_v2_card_holder_account_provision_attempts_last24_hours     = 1
    request.threeds_v2_card_holder_account_purchases_count_last6_months        = 5
    request.threeds_v2_card_holder_account_suspicious_activity_indicator       =
            GenesisRuby::Api::Constants::Transactions::Parameters::Threeds::Version2::CardHolderAccount::SuspiciousActivityIndicators::NO_SUSPICIOUS_OBSERVED
    request.threeds_v2_card_holder_account_registration_indicator              =
            GenesisRuby::Api::Constants::Transactions::Parameters::Threeds::Version2::CardHolderAccount::RegistrationIndicators::MORE_THAN_60DAYS
    request.threeds_v2_card_holder_account_registration_date                   = '31-12-2022'

  end.execute

  response_3ds_v2 = genesis_3ds_v2.response

  if response_3ds_v2.approved?
    # Transaction approved no customer action required
    # Test Case: Synchronous 3DSv2 Request with Frictionless flow
    puts response_3ds_v2.response_object
  end

  if response_3ds_v2.declined? || response_3ds_v2.error?
    # Transaction declined no customer action required
    # Synchronous 3DSv2 Request with Frictionless flow
    puts response_3ds_v2.response_object
  end

  if response_3ds_v2.pending_async?
    # Additional Actions Required
    response_object_3ds_v2 = response_3ds_v2.response_object

    if response_object_3ds_v2[:redirect_url]
      # An interaction between consumer and issuer is required
      # 3DSv2 Challenge required
      # 3DSv1 payer authentication required - fallback from 3DSv2 to 3DSv1
      # Test Case: Asynchronous 3DSv2 Request with Challenge flow
      # Test Case: Asynchronous 3DSv2 Request with Fallback flow
      puts response_object_3ds_v2[:redirect_url_type]
      puts response_object_3ds_v2[:redirect_url]
    end

    if response_object_3ds_v2[:threeds_method_url]
      # 3DS-Method submission is required
      # Generate 3DSv2-Method Signature token used for Threeds Method Continue Request. It's not required when the 3DS-Method continue request is built by the initial request's response object.
      puts GenesisRuby::Utils::Threeds::V2.generate_signature(
              unique_id: response_object_3ds_v2[:unique_id],
              amount: response_object_3ds_v2[:amount],
              timestamp: response_object_3ds_v2[:timestamp].strftime(GenesisRuby::Api::Constants::DateTimeFormats::YYYY_MM_DD_H_I_S_ZULU),
              merchant_password: configuration.password
      )

      # Execute 3DS-Method Continue Request after initiating the 3DS-Method submission
      # The new request is loaded from the response object of the initial request
      genesis_3ds_v2_continue = GenesisRuby::Api::Requests::Financial::Cards::Threeds::V2::MethodContinue.build_from_response_object(
              configuration,
              genesis_3ds_v2.response.response_object
      )

      genesis_3ds_v2_continue.execute

      response_3ds_v2_continue = genesis_3ds_v2_continue.response

      if response_3ds_v2_continue.approved?
        # Transaction APPROVED no customer action required
        # Test Case: Asynchronous 3DSv2 Request with 3DS-Method and Frictionless flow
        puts response_3ds_v2_continue.response_object
      end

      if response_3ds_v2_continue.declined? || response_3ds_v2_continue.error?
        # Transaction declined no customer action required
        puts response_3ds_v2_continue.response_object
      end

      if response_3ds_v2_continue.pending_async?
        # Customer action required
        continue_response_object = response_3ds_v2_continue.response_object

        if continue_response_object[:redirect_url]
          # Test Case: Asynchronous 3DSv2 Request with 3DS-Method Challenge flow
          # Test Case: Asynchronous 3DSv2 Request with 3DS-Method Fallback flow
          puts continue_response_object[:redirect_url_type]
          puts continue_response_object[:redirect_url]
        end
      end
    end
  end

rescue GenesisRuby::Error => error
  puts error.message
end
```

</details>

### Standalone ThreedsV2 Method Continue Request.

<details>

```ruby
require 'genesis_ruby'

begin
  genesis = GenesisRuby::Genesis.for(config: configuration, request: GenesisRuby::Api::Requests::Financial::Cards::Threeds::V2::MethodContinue) do |request|
    # Amount in minor currency unit
    # If the AMOUNT is not in a minor currency unit then SET the CURRENCY. The AMOUNT will be converted into minor currency unit internally using the CURRENCY property.
    # Ex. amount = 10.00
    #     currency = 'EUR'
    #   The AMOUNT in that case for signature generation will be 1000
    # Amount is included in the response from the initial request in major currency unit genesis.response.response_object[:amount]
    request.amount = 10.00

    # If CURRENCY is set, AMOUNT value will be converted into MINOR currency unit
    # If you SET the AMOUNT in MINOR currency unit DO NOT set CURRENCY
    # Currency is included in the response from the initial request in major currency unit genesis.response.response_object[:currency]
    request.currency = 'EUR'

    # Set only one of the unique_id or url
    # request.url = 'https://staging.gate.emerchantpay.net/threeds/threeds_method/d6a6aa96292e4856d4a352ce634a4335'
    request.transaction_unique_id = 'd6a6aa96292e4856d4a352ce634a4335'

    # String representation of the timestamp
    # request.transaction_timestamp = genesis.response
    #   .response_object[:timestamp].strftime(GenesisRuby::Api::Constants::DateTimeFormats::YYYY_MM_DD_H_I_S_ZULU)
    request.transaction_timestamp = '2020-12-31T23:59:59Z'
  end.execute

  response = genesis.response

  if response.approved?
    # Asynchronous 3DSv2 Request with 3DS-Method and Frictionless flow
    # Transaction approved no customer action required
    puts response.response_object
  end

  if response.pending_async?
    # Customer action required
    response_object = response.response_object

    if response_object[:redirect_url]
      # Asynchronous 3DSv2 Request with 3DS-Method Challenge flow
      # Asynchronous 3DSv2 Request with 3DS-Method Fallback flow
      puts response_object[:redirect_url_type]
      puts response_object[:redirect_url]
    end
  end

rescue GenesisRuby::Error => error
  puts error.message
end
```

</details>

### Apple Pay Request

Apple Pay is a mobile payment solution available on iOS devices with Touch ID / Face ID support. Apple Pay allows shoppers to purchase with credit and debit cards linked to their devices.

<details>
<summary>Apple Pay Transaction Example</summary>

```ruby
require 'genesis_ruby'

begin
  genesis = GenesisRuby::Genesis.for(config:  configuration, request: GenesisRuby::Api::Requests::Financial::Mobile::ApplePay) do |request|
    # Common Attributes
    request.transaction_id     = '12345-67890'
    request.amount             = '0.99'
    request.currency           = 'EUR'
    request.usage              = 'Example usage'
    request.customer_email     = 'travis@example.com'
    request.customer_phone     = '+1987987987987'

    request.payment_subtype    = GenesisRuby::Api::Constants::Transactions::Parameters::Mobile::ApplePay::PaymentSubtypes::SALE

    # Billing Attributes
    request.billing_first_name = 'Travis'
    request.billing_last_name  = 'Pastrana'
    request.billing_address1   = 'Muster Str. 12'
    request.billing_zip_code   = '10178'
    request.billing_city       = 'Los Angeles'
    request.billing_state      = 'CA'
    request.billing_country    = 'US'

    # Apple Pay Payment Token
    json_token = '{"paymentData":{"version":"EC_v1","data":"MgcrhHr/uhfRy7zxMOvahhf5sp+ZfUsWADlG5OhvZ8vEAybEouyk4tT8oYaOqlfNTdkJZl2tmCgyLReibOjW2RiXzw5S9ZtA6ISnEBjNFla9Hju1KJnxQ+QFIdSlhEDOqN/Wk9kSFz2mnT8wajaG6mytpXhzCxvl5ElCp0gm0wMb82lvpf6my5TIu+CuANPZ2g/kslqKUGEjQHhO3FVqmiEj2YpkrlhXcvFu1GalTOWgjnLVCMz8l8DCQek/UIZQ3ZiJEoQTlEZRzXlwG8FlEp/QwbLiIlQfDLCtu3pBH0EaOeQ1OwupXs64EYfL+DEzYKdpi7dE9Y93zcXR6y2qsawBC8lCeI8zGc+kRFQJ5IrPd81BRZep3xsHwh1uki2dfx2taLyjxyCWWKaUWCzYI1p/u7YsypYEMj3np+MHfg==","signature":"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","header":{"wrappedKey": "wrapped key", "ephemeralPublicKey":"MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEJsaMBlzR3D0H7xKwDncLNGOEcsl6Jilx5d+MDI/1QFxuIf6a0fY5qgOwnuLgZepqc3AVeU1RV8enPCQSWfFKRg==","publicKeyHash":"QOmvMaoCNYk5tv+69KC1i2UCFQcOl6LYPIJfYAT+SLQ=","transactionId":"ccedaf3f32efcc971259694f0efd0dcaa0ed545e7a31a0f7ec8e1c110656c25b"}},"paymentMethod":{"displayName":"Visa 0225","network":"Visa","type":"debit"},"transactionIdentifier":"CCEDAF3F32EFCC971259694F0EFD0DCAA0ED545E7A31A0F7EC8E1C110656C25B"}'

    # Set Apple Pay token from a JSON string
    request.json_token = json_token

    # Alternatively you can set every token attributes
    # token = JSON.parse json_token
    # request.token_version                = token['paymentData']['version']
    # request.token_data                   = token['paymentData']['data']
    # request.token_signature              = token['paymentData']['signature']
    # request.token_ephemeral_public_key   = token['paymentData']['header']['ephemeralPublicKey']
    # request.token_public_key_hash        = token['paymentData']['header']['publicKeyHash']
    # request.token_transaction_id         = token['paymentData']['header']['transactionId']
    # request.token_display_name           = token['paymentMethod']['displayName']
    # request.token_network                = token['paymentMethod']['network']
    # request.token_type                   = token['paymentMethod']['type']
    # request.token_transaction_identifier = token['transactionIdentifier']
  end.execute

  puts genesis.response.response_object
rescue GenesisRuby::Error => error
  puts error.message
end
```

</details>

<details>
<summary>Apple Pay Web Payment Form Example</summary>

```ruby
require 'genesis_ruby'

begin
  genesis = GenesisRuby::Genesis.for(config: configuration, request: GenesisRuby::Api::Requests::Wpf::Create) do |request|
    # Common Attributes
    request.transaction_id     = '12345-67890'
    request.amount             = '0.99'
    request.currency           = 'EUR'
    request.usage              = 'Example usage'
    request.description        = 'You are about to complete you purchase'
    request.customer_email     = 'travis@example.com'
    request.customer_phone     = '+1987987987987'
    request.notification_url   = 'https://www.example.com/notification'
    request.return_success_url = 'https://www.example.com/success'
    request.return_cancel_url  = 'https://www.example.com/failure'
    request.return_failure_url = 'https://www.example.com/cancel.html'
    request.return_pending_url = 'https://www.example.com/payment-pending.html'

    # Transaction Types
    request.add_transaction_type('apple_pay', { payment_subtype: GenesisRuby::Api::Constants::Transactions::Parameters::Mobile::ApplePay::PaymentSubtypes::AUTHORIZE })

    # Billing Attributes
    request.billing_first_name = 'Travis'
    request.billing_last_name  = 'Pastrana'
    request.billing_address1   = 'Muster Str. 12'
    request.billing_zip_code   = '10178'
    request.billing_city       = 'Los Angeles'
    request.billing_state      = 'CA'
    request.billing_country    = 'US'
  end.execute

  puts genesis.response.response_object

rescue GenesisRuby::Error => error
  puts error.message
end
```

</details>

### Google Pay Request

Google Pay allows shoppers to purchase with credit and debit cards linked to their Google account.

<details>
<summary>Google Pay Transaction Example</summary>

```ruby
require 'genesis_ruby'

begin
  genesis = GenesisRuby::Genesis.for(config:  configuration, request: GenesisRuby::Api::Requests::Financial::Mobile::GooglePay) do |request|
    # Common Attributes
    request.transaction_id     = '12345-67890'
    request.amount             = '0.99'
    request.currency           = 'EUR'
    request.usage              = 'Example usage'
    request.customer_email     = 'travis@example.com'
    request.customer_phone     = '+1987987987987'

    request.payment_subtype    = GenesisRuby::Api::Constants::Transactions::Parameters::Mobile::GooglePay::PaymentSubtypes::SALE

    # Billing Attributes
    request.billing_first_name = 'Travis'
    request.billing_last_name  = 'Pastrana'
    request.billing_address1   = 'Muster Str. 12'
    request.billing_zip_code   = '10178'
    request.billing_city       = 'Los Angeles'
    request.billing_state      = 'CA'
    request.billing_country    = 'US'

    # Google Pay Payment Token
    json_token = '{
            "protocolVersion":"ECv2",
            "signature":"MEQCIH6Q4OwQ0jAceFEkGF0JID6sJNXxOEi4r+mA7biRxqBQAiAondqoUpU/bdsrAOpZIsrHQS9nwiiNwOrr24RyPeHA0Q\u003d\u003d",
            "intermediateSigningKey":{
                    "signedKey": "{\"keyExpiration\":\"1542323393147\",\"keyValue\":\"MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAE/1+3HBVSbdv+j7NaArdgMyoSAM43yRydzqdg1TxodSzA96Dj4Mc1EiKroxxunavVIvdxGnJeFViTzFvzFRxyCw\\u003d\\u003d\"}",
                    "signatures": ["MEYCIQCO2EIi48s8VTH+ilMEpoXLFfkxAwHjfPSCVED/QDSHmQIhALLJmrUlNAY8hDQRV/y1iKZGsWpeNmIP+z+tCQHQxP0v"]
            },
            "signedMessage":"{\"tag\":\"jpGz1F1Bcoi/fCNxI9n7Qrsw7i7KHrGtTf3NrRclt+U\\u003d\",\"ephemeralPublicKey\":\"BJatyFvFPPD21l8/uLP46Ta1hsKHndf8Z+tAgk+DEPQgYTkhHy19cF3h/bXs0tWTmZtnNm+vlVrKbRU9K8+7cZs\\u003d\",\"encryptedMessage\":\"mKOoXwi8OavZ\"}"
    }'

    # Set Google Pay token from a JSON string
    request.json_token = json_token

    # Alternatively you can set every token attributes
    # token = JSON.parse json_token
    # request.token_protocol_version = token['protocolVersion']
    # request.token_signature        = token['signature']
    # request.token_signed_key       = token['intermediateSigningKey']['signedKey']
    # request.token_signatures       = token['intermediateSigningKey']['signatures']
    # request.token_signed_message   = token['signedMessage']
  end.execute

  puts genesis.response.response_object
rescue GenesisRuby::Error => error
  puts error.message
end
```

</details>

<details>
<summary>Google Pay Web Payment Form Example</summary>

```ruby
require 'genesis_ruby'

begin
  genesis = GenesisRuby::Genesis.for(config: configuration, request: GenesisRuby::Api::Requests::Wpf::Create) do |request|
    # Common Attributes
    request.transaction_id     = '12345-67890'
    request.amount             = '0.99'
    request.currency           = 'EUR'
    request.usage              = 'Example usage'
    request.description        = 'You are about to complete you purchase'
    request.customer_email     = 'travis@example.com'
    request.customer_phone     = '+1987987987987'
    request.notification_url   = 'https://www.example.com/notification'
    request.return_success_url = 'https://www.example.com/success'
    request.return_cancel_url  = 'https://www.example.com/failure'
    request.return_failure_url = 'https://www.example.com/cancel.html'
    request.return_pending_url = 'https://www.example.com/payment-pending.html'

    # Transaction Types
    request.add_transaction_type('google_pay', { payment_subtype: GenesisRuby::Api::Constants::Transactions::Parameters::Mobile::GooglePay::PaymentSubtypes::AUTHORIZE })

    # Billing Attributes
    request.billing_first_name = 'Travis'
    request.billing_last_name  = 'Pastrana'
    request.billing_address1   = 'Muster Str. 12'
    request.billing_zip_code   = '10178'
    request.billing_city       = 'Los Angeles'
    request.billing_state      = 'CA'
    request.billing_country    = 'US'
  end.execute

  puts genesis.response.response_object

rescue GenesisRuby::Error => error
  puts error.message
end
```

</details>

### Recurring

A recurring transaction describes a payment where the cardholder’s account is periodically charged for a repeated 
delivery and use of a product or service (subscription, membership fee, etc.) over time. A recurring payment consists of an initial transaction and one or several repeated subsequent transactions.

```ruby
request.recurring_type = GenesisRuby::Api::Constants::Transactions::Parameters::Recurring::Types::INITIAL
```

#### Managed Recurring

Managed Recurring provides the option to automatically schedule recurring transactions for a specific day and time.
Managed Recurring is available after additional configuration. More info can be found [here](https://emerchantpay.github.io/gateway-api-docs/?shell#managed-recurring-intro)

```ruby
request.recurring_type = GenesisRuby::Api::Constants::Transactions::Parameters::Recurring::Types::MANAGED
```

* <details>
  <summary>Web Payment Form</summary>
  
  ```ruby
  request.add_transaction_type(
    'sale3d',
    {
      managed_recurring: {
        mode:        'automatic',
        interval:    'days',
        first_date:  ((Date.today) + 1).strftime('%Y-%d-%m'),
        time_of_day: 1,
        period:      1,
        amount:      GenesisRuby::Utils::MoneyFormat.amount_to_exponent('0.99', 'EUR'),
        max_count:   1
      }
    }
  )
  ```
  </details>

#### Level 3 Travel Data
Level 3 travel data is supplied as optional data to the standard API request. If the supplied is valid travel data then the transaction will be processed as a travel transaction and will qualify for the travel Incentive rates. Otherwise the transaction will be processed normally as a regular transaction. Note that the travel data will be stored as part of the transaction in all cases.

<details>
<summary>Example Leg Data</summary>

```ruby
GenesisRuby::Utils::Transactions::TravelData::AirlineItinerary::Leg.new departure_date:         '2034-12-31',
                                                                        arrival_date:           '2034-12-31',
                                                                        carrier_code:           12,
                                                                        service_class:          1,
                                                                        origin_city:            'VAR',
                                                                        destination_city:       'FRA',
                                                                        stopover_code:          0,
                                                                        fare_basis_code:        1,
                                                                        flight_number:          'W1234',
                                                                        departure_time:         '11:37',
                                                                        departure_time_segment: 'P'
```

</details>

<details>
<summary>Example Tax Data</summary>

```ruby
GenesisRuby::Utils::Transactions::TravelData::AirlineItinerary::Tax.new fee_type: 'type', 
                                                                        fee_amount: 0.99 # will converted automatically to minor format based on the currency
```

</details>

<details>
<summary>Example Level 3 Travel Data</summary>

```ruby
# Ticket attributes
request.travel_aid_ticket_number               = '123456789012345'
request.travel_aid_passenger_name              = 'Test Example'
request.travel_aid_customer_code               = 1
request.travel_aid_issuing_carrier             = 'AAAA'
request.travel_aid_total_fare                  = '0.99' # will converted automatically to minor format based on the currency
request.travel_aid_agency_name                 = 'Agency'
request.travel_aid_agency_code                 = 'AG001'
request.travel_aid_date_of_issue               = '2018-02-01'
request.travel_aid_restricted_ticket_indicator = 1
request.travel_aid_confirmation_information    = 'Confirmation'

request.add_travel_aid_leg leg
request.add_travel_aid_tax tax

# Car rental
request.travel_car_rental_purchase_identifier       = '12478'
request.travel_car_rental_class_id                  = 3
request.travel_car_rental_pickup_date               = '2034-12-31'
request.travel_car_rental_renter_name               = 'John Smith'
request.travel_car_rental_return_city               = 'Varna'
request.travel_car_rental_return_state              = 'VAR'
request.travel_car_rental_return_country            = 'BGR'
request.travel_car_rental_return_date               = '2034-12-31'
request.travel_car_rental_renter_return_location_id = '12478'
request.travel_car_rental_customer_code             = 1
request.travel_car_rental_extra_charges             = 2
request.travel_car_rental_no_show_indicator         = 1

# Hotel Rental attributes
request.travel_hotel_rental_purchase_identifier = '12478'
request.travel_hotel_rental_arrival_date        = '2034-12-31'
request.travel_hotel_rental_departure_date      = '2034-12-31'
request.travel_hotel_rental_customer_code       = '12478'
request.travel_hotel_rental_no_show_indicator   = 1

# Reference Ticket Attributes
request.travel_ac_ticket_reference_id       = '8b7e3575e5605ea7e1895707a3e92837'
request.travel_ac_ticket_document_number    = '1111'
request.travel_ac_issued_with_ticket_number = '12321'

# Ancillary Charges
request.travel_ac_type     = 'BF'
request.travel_ac_sub_type = 'BG'
```

</details>

## Response

After Request execution (`genesis.execute`) a Response object can be accessed `genesis.response`.  

The Response contains the original response from the Gateway:
```ruby
genesis.response.response_raw
```

The Response contains the parsed response from the Gateway:
```ruby
genesis.response.response_object
```

### Success Request

You receive from the Response Object a Hash collection. The data contains a `:status`.


If the Transaction is Successful the status is one of the following:
* `new`
* `approved`
* `pending_async`

<details>
<summary>Example Successful Transaction Execution</summary>

```ruby
  {:status=>"new",
  :unique_id=>"2993ad9c2dd45ecfa9862b9eaf0ceb29",
  :transaction_id=>"9c8b862b-4f91-478b-8a14-87bffab7e55d",
  :timestamp=>
  #<DateTime: 2023-04-20T12:11:42+00:00 ((2460055j,43902s,0n),+0s,2299161j)>,
  :amount=>"0.99",
  :currency=>"EUR",
  :redirect_url=>
  "https://staging.wpf.emerchantpay.net/ja/v2/payment/2993ad9c2dd45ecfa9862b9eaf0ceb29"}
```
</details>

If an error occurs during the Transaction Execution the status is one of the following:
* `error`
* `declined`

<details>
<summary>Example Transaction Execution with Error</summary>

```ruby
{:status=>"error",
 :unique_id=>"fc94d7cdebe5f81618785d1033948fcc",
 :transaction_id=>"8bf4556b-a6ba-4389-a2e8-b7efa9e384b3",
 :code=>"120",
 :technical_message=>
   "Lacking Terminal/MID setups for the currency 'USD' for the requested transaction types",
 :message=>"Transaction failed, please contact support!",
 :timestamp=>
   #<DateTime: 2023-04-20T12:13:52+00:00 ((2460055j,44032s,0n),+0s,2299161j)>,
   :amount=>"0.99",
 :currency=>"USD"}
```
</details>

### Reference actions
The Reference transaction requests allow actions over an existing payment. The payment can be modified with:
* Capture - settles a transaction that has been authorized before
* Void - undo other transactions
* Refund -  allow to return already billed amounts to customers

<kbd>!</kbd> Void transaction request doesn't require amount and currency parameters

After a successful response of a payment, reference actions can be executed by using the `unique_id`.

```ruby
require 'genesis_ruby'

begin
  genesis = GenesisRuby::Genesis.for(config: configuration, request: GenesisRuby::Api::Requests::Financial::Refund) do |request|
    request.transaction_id = '12345-67890'
    request.amount         = '0.99' # not available for GenesisRuby::Api::Requests::Financial::Void
    request.currency       = 'EUR' # not available for GenesisRuby::Api::Requests::Financial::Void
    request.usage          = 'Example usage'
    request.reference_id   = 'unique_id received upon successful payment transaction'
  end.execute

  puts genesis.response.response_object

rescue GenesisRuby::Error => error
  puts error.message
end
```

### Gateway Notification

With the asynchronous payment flows like Web Payment Form the Gateway sends the transaction events upon status change on the defined `notification_url`.
The library contains a Notification module that helps handle the received gateway notification and can provide easy reconciliation execution.

#### Initialization
The notification module requires notification data or any object that responds to `to_h` with a Hash return value.
For example, with Ruby on Rails you can permit the params and to_h method can be executed without errors:

```ruby
permitted_params = params.permit(:transaction_id, :terminal_token, :unique_id, :transaction_type, :status, :signature, :amount)
```
A full list of the available params that can be received upon notification can be found [here](https://emerchantpay.github.io/gateway-api-docs/?shell#asynchronous-transactions).

```ruby
begin
  notification = GenesisRuby::Api::Notification.new configuration, permitted_params

  # Helper methods
  notification.api_notification?
  notification.wpf_notification?
  notification.unique_id

  # Executes Gateway Transaction Reconciliation
  # This provides the latest information on the transaction from the Gateway
  notification.reconcile

  # Provides information if the given reconcile response contains transaction information
  notification.transaction_reconciliation?

  # Get the Reconcile Response Object in Hash data structure
  notification.reconciliation.response_object

  # Generate response document expected from the Gateway
  notification.generate_response
rescue GenesisRuby::ParameterError => error
  puts error.message
end
```

#### Reconcile
Minimum required data for execution of `reconcile`:

```ruby
{
  unique_id: 'unique_id received from the gateway in the notification params',
  signature: 'the signature received in the notification'
}
```

If the signature can't be verified Genesis::Ruby::ParameterError will be raised.

#### Helpers
`notification.reconcile` returns GenesisRuby::Api::Response. The response object can be accessed via `notification.reconciliation`.
The reconciliation object has every helper that [Response](#response-helpers) contains like checking the status with `error?`, `approved?`, etc.

For checking if the `reconciliation.response_object` is a successful transaction response you can use `notification.transaction_reconciliation?`

#### Errors
Upon wrong data like configuration terminal token, `reconciliation.response_object` can be similar:

```ruby
{
   status: 'error',
   code: '220',
   message: 'Reconcile request failed, please contact support!',
   technical_message: 'Invalid Terminal'
}
```

#### Respond to the Gateway
When receiving the notification, you are required to render an xml page containing the transaction’s unique id so that the gateway knows that you have accepted the notification.
If the XML is not delivered, the notification is sent periodically until the XML is received.

`GenesisRuby::Api::Notification` provides helper method for generation of the expected xml content. The Gateway expects a response with:
* Status 200
* Content Type `text/xml`

```ruby
notification.generate_response
```

### Response Helpers

#### Sates

The Response object has predefined checks for validating the status of the received response. 
Every available status received from the Gateway can be checked in the following way.

```ruby
genesis.response.new?
genesis.response.approved?
genesis.response.declined?
genesis.response.error?
...
```

#### Formatters

By default, the Response Object is formatted. For example, amounts are transformed in major currency format, timestamps in `DateTime`, etc.
If you want to stop formatting you can do it by defining `format_reponse` in the [Configuration](#Configuration).

```ruby
configuration.format_response = false
```

#### Sanitization

By default, the Response Object is sanitized, and `<empty/>` values are removed.
If you want to stop sanitization you can do it by defining `configuration.sanitize_response` in the [Configuration](#Configuration).

```ruby
configuration.sanitize_response = false
```

## Requests

You can use the following request classes to initialize the Genesis client:

```ruby
# Financial
## Cards
GenesisRuby::Api::Requests::Financial::Cards::Argencard
GenesisRuby::Api::Requests::Financial::Cards::Aura
GenesisRuby::Api::Requests::Financial::Cards::Authorize
GenesisRuby::Api::Requests::Financial::Cards::Authorize3d
GenesisRuby::Api::Requests::Financial::Cards::Bancontact
GenesisRuby::Api::Requests::Financial::Cards::Cabal
GenesisRuby::Api::Requests::Financial::Cards::Cencosud
GenesisRuby::Api::Requests::Financial::Cards::Elo
GenesisRuby::Api::Requests::Financial::Cards::Naranja
GenesisRuby::Api::Requests::Financial::Cards::Nativa
GenesisRuby::Api::Requests::Financial::Cards::Sale
GenesisRuby::Api::Requests::Financial::Cards::Sale3d
GenesisRuby::Api::Requests::Financial::Cards::TarjetaShopping

## Mobile
GenesisRuby::Api::Requests::Financial::Mobile::ApplePay
GenesisRuby::Api::Requests::Financial::Mobile::GooglePay

## Wallets
GenesisRuby::Api::Requests::Financial::Wallets::Alipay
GenesisRuby::Api::Requests::Financial::Wallets::PayPal

## Cash Payments
GenesisRuby::Api::Requests::Financial::CashPayments::Baloto
GenesisRuby::Api::Requests::Financial::CashPayments::BancoDeOccidente
GenesisRuby::Api::Requests::Financial::CashPayments::Boleto
GenesisRuby::Api::Requests::Financial::CashPayments::Cash
GenesisRuby::Api::Requests::Financial::CashPayments::Efecty
GenesisRuby::Api::Requests::Financial::CashPayments::Oxxo
GenesisRuby::Api::Requests::Financial::CashPayments::PagoFacil
GenesisRuby::Api::Requests::Financial::CashPayments::Pix
GenesisRuby::Api::Requests::Financial::CashPayments::Redpagos

# Web Payment Form
## Create
GenesisRuby::Api::Requests::Wpf::Create
## WPF Reconcile
GenesisRuby::Api::Requests::Wpf::Reconcile

# Online Banking Payments
GenesisRuby::Api::Requests::Financial::OnlineBankingPayments::BancoDoBrasil
GenesisRuby::Api::Requests::Financial::OnlineBankingPayments::Bancomer
GenesisRuby::Api::Requests::Financial::OnlineBankingPayments::Bradesco
GenesisRuby::Api::Requests::Financial::OnlineBankingPayments::Davivienda
GenesisRuby::Api::Requests::Financial::OnlineBankingPayments::Eps
GenesisRuby::Api::Requests::Financial::OnlineBankingPayments::Itau
GenesisRuby::Api::Requests::Financial::OnlineBankingPayments::Multibanco
GenesisRuby::Api::Requests::Financial::OnlineBankingPayments::PayU
GenesisRuby::Api::Requests::Financial::OnlineBankingPayments::PostFinance
GenesisRuby::Api::Requests::Financial::OnlineBankingPayments::MyBank
GenesisRuby::Api::Requests::Financial::OnlineBankingPayments::Pse
GenesisRuby::Api::Requests::Financial::OnlineBankingPayments::RapiPago
GenesisRuby::Api::Requests::Financial::OnlineBankingPayments::SafetyPay
GenesisRuby::Api::Requests::Financial::OnlineBankingPayments::Santander
GenesisRuby::Api::Requests::Financial::OnlineBankingPayments::TrustlySale
GenesisRuby::Api::Requests::Financial::OnlineBankingPayments::Upi
GenesisRuby::Api::Requests::Financial::OnlineBankingPayments::Sofort
GenesisRuby::Api::Requests::Financial::OnlineBankingPayments::Webpay
GenesisRuby::Api::Requests::Financial::OnlineBankingPayments::Wechat
# PayIn
GenesisRuby::Api::Requests::Financial::OnlineBankingPayments::OnlineBanking::PayIn
# PayOut
GenesisRuby::Api::Requests::Financial::OnlineBankingPayments::OnlineBanking::PayOut
# iDebit
GenesisRuby::Api::Requests::Financial::OnlineBankingPayments::Idebit::PayIn
GenesisRuby::Api::Requests::Financial::OnlineBankingPayments::Idebit::PayOut
# InstaDebit
GenesisRuby::Api::Requests::Financial::OnlineBankingPayments::InstaDebit::PayIn
GenesisRuby::Api::Requests::Financial::OnlineBankingPayments::InstaDebit::PayOut

# SDD
GenesisRuby::Api::Requests::Financial::Sdd::Sale
GenesisRuby::Api::Requests::Financial::Sdd::Recurring::InitRecurringSale

# References
GenesisRuby::Api::Requests::Financial::Capture
GenesisRuby::Api::Requests::Financial::Void
GenesisRuby::Api::Requests::Financial::Refund
GenesisRuby::Api::Requests::Financial::Sdd::Refund
GenesisRuby::Api::Requests::Financial::Sdd::Recurring::RecurringSale

# Non Financial
## Reconcile
GenesisRuby::Api::Requests::NonFinancial::Reconcile::Transaction
GenesisRuby::Api::Requests::NonFinancial::Reconcile::DateRange

## Installments
GenesisRuby::Api::Requests::NonFinancial::Installments::Fetch

## Billing API
GenesisRuby::Api::Requests::NonFinancial::BillingApi::Transactions

## Consumer API
GenesisRuby::Api::Requests::NonFinancial::Consumers::Create
GenesisRuby::Api::Requests::NonFinancial::Consumers::Retrieve
GenesisRuby::Api::Requests::NonFinancial::Consumers::Update
GenesisRuby::Api::Requests::NonFinancial::Consumers::Disable
GenesisRuby::Api::Requests::NonFinancial::Consumers::Enable
GenesisRuby::Api::Requests::NonFinancial::Consumers::GetCards

## Retrieval API
GenesisRuby::Api::Requests::NonFinancial::Fraud::Retrieval::Transaction
GenesisRuby::Api::Requests::NonFinancial::Fraud::Retrieval::DateRange

## SCA API
GenesisRuby::Api::Requests::NonFinancial::Sca::Checker

## Processed Transaction API
GenesisRuby::Api::Requests::NonFinancial::ProcessedTransactions::Transaction
GenesisRuby::Api::Requests::NonFinancial::ProcessedTransactions::DateRange
GenesisRuby::Api::Requests::NonFinancial::ProcessedTransactions::PostDateRange

## Tokenization API
GenesisRuby::Api::Requests::NonFinancial::Tokenization::Tokenize
GenesisRuby::Api::Requests::NonFinancial::Tokenization::Detokenize
GenesisRuby::Api::Requests::NonFinancial::Tokenization::UpdateToken
GenesisRuby::Api::Requests::NonFinancial::Tokenization::Cryptogram
GenesisRuby::Api::Requests::NonFinancial::Tokenization::ValidateToken
GenesisRuby::Api::Requests::NonFinancial::Tokenization::DeleteToken
GenesisRuby::Api::Requests::NonFinancial::Tokenization::GetCard

```

### Manual initialization

<details>
<summary>Manual Client initialization</summary>

```ruby
require 'genesis_ruby'

begin
  request = GenesisRuby::Api::Requests::Wpf::Create.new(configuration)

  request.transaction_id     = '12345-67890'
  request.amount             = '0.99'
  request.currency           = 'EUR'
  request.usage              = 'Example usage'
  request.description        = 'You are about to complete you purchase'
  request.customer_email     = 'travis@example.com'
  request.customer_phone     = '+1987987987987'
  request.notification_url   = 'https://www.example.com/notification'
  request.return_success_url = 'https://www.example.com/success'
  request.return_cancel_url  = 'https://www.example.com/failure'
  request.return_failure_url = 'https://www.example.com/cancel.html'
  request.return_pending_url = 'https://www.example.com/payment-pending.html'

  # Transaction Types
  request.add_transaction_type('authorize3d')
  
  genesis = GenesisRuby::Genesis.new(configuration, request)

  puts genesis.execute.response.response_object

rescue GenesisRuby::Error => error
  puts error.message
end
```

</details>

## Running Specs

`rake test`

## Running Linters

`rake styles`
