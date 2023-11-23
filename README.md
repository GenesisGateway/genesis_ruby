
# Genesis Ruby

[![Software License](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](LICENSE)

Ruby Client for Genesis Payment Processing Gateway

## Overview

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
GenesisRuby::Api::Requests::Financial::Cards::Authorize
GenesisRuby::Api::Requests::Financial::Cards::Authorize3d
GenesisRuby::Api::Requests::Financial::Cards::Sale
GenesisRuby::Api::Requests::Financial::Cards::Sale3d

# Web Payment Form
## Create
GenesisRuby::Api::Requests::Wpf::Create
GenesisRuby::Api::Requests::Wpf::Reconcile

# References
GenesisRuby::Api::Requests::Financial::Capture
GenesisRuby::Api::Requests::Financial::Void
GenesisRuby::Api::Requests::Financial::Refund

# Non Financial
## Reconcile
GenesisRuby::Api::Requests::NonFinancial::Reconcile::Transaction
GenesisRuby::Api::Requests::NonFinancial::Reconcile::DateRange
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
