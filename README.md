
# Genesis Ruby

[![Software License](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](LICENSE)

Ruby Client for Genesis Payment Processing Gateway

## Overview

Client Library for processing payments through Genesis Payment Processing Gateway. Its highly recommended to checkout "Genesis Payment Gateway API Documentation" first, in order to get an overview of Genesis's Payment Gateway API and functionality.

## Requirements

* Ruby version 2.7 or newer

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

A full list of the Transaction Types and Custom Attributes can be found [here](https://emerchantpay.github.io/gateway-api-docs/?shell#wpf-transaction-types).

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
# Transactions
## Cards
GenesisRuby::Api::Requests::Financial::Cards::Authorize
GenesisRuby::Api::Requests::Financial::Cards::Authorize3d
GenesisRuby::Api::Requests::Financial::Cards::Sale
GenesisRuby::Api::Requests::Financial::Cards::Sale3d

# Web Payment Form
## Create
GenesisRuby::Api::Requests::Wpf::Create
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
