0.3.1
-----

**Fixes**:

* Fixed Void transaction request execution

0.3.0
-----
**Features**:

* Removed the following transaction types from Web Payment Form:
  * banco_do_brasil
  * bradesco
  * itau
  * pse
  * redpagos
  * santander
  * webpay

0.2.8
-----
**Features**

* Add Smart Router support with single Reconcile
* Add PATCH method support
* Add Update Payee and Update Payee Account request support
* Add parse_email restricted setter

0.2.7
-----
**Features**:

* Added KYC CPF Check API request support
* Added KYC CNPJ Check API request support
* Added KYC Verification Register API request support
* Added KYC Verification Status API request support
* Added KYC Identity Document Download API request support
* Added KYC Make Call API request support
* Added KYC Update Call API request support
* Added KYC Identity Document Upload API request support
* Added KYC Transaction Create API request support
* Added KYC Transaction Update API request support
* Added Global Payout transaction request support
* Added Create and Retrieve Payee API requests support
* Added Create, Retrieve, List Payee Account API requests support

0.2.6
-----
**Features**:

* Added Partial Reversal transaction request support
* Added KYC Remote Identity Verification API request support
* Added KYC Update Consumer Registration API request support

0.2.5
-----
**Features**:

* Added Incremental Authorize transaction request support
* Added Preauthorization attributes support to Authorize and Authorize 3D transaction requests
* Added BitPay Sale, Refund and Payout transaction requests support
* Added support for the following Gift Card transaction requests:
  * Fashioncheque
  * Intersolve
  * TCS
* Added Chargeback API support with the following endpoints:
  * Single/List
  * By Date Range
* Added Fraud reports API support with the following endpoints:
  * Single/List SAFE/TC40
  * By Date Range
* Added FX API services support with the following endpoints:
  * GetRate
  * GetRates
  * GetTier
  * GetTiers
  * SearchRate
* Added KYC Create Consumer Registration API request support
* Added XCG currency support
* Updated Tokenization Cryptogram API request support with mandatory parameter - transaction_reference
* Added Digital Asset Type attribute support to the following transaction requests:
  * Authorize
  * Authorize 3D
  * Sale
  * Sale 3D
  * Web Payment Form
* Added African Mobile Sale transaction request support
* Added Russian Mobile Sale transaction request support
* Added Credit transaction request support
* Added Neosurf transaction request support
* Added Payout transaction request support

0.2.4
-----
**Features**:

* Added Tokenization API support:
  * Tokenize
  * Detokenize
  * Token
  * Cryptogram
  * Validate token
  * Delete token
  * Get Card
* Added Payer attributes support to Bank Payout
* Added Beneficiary attributes support to PIX transaction request
* Added Processed Transactions API support:
  * Single Processed Transaction
  * By Date Range
  * Post By Date Range
* Added SCA Checker API support
* Added Retrieval API support:
  * Single Retrieval
  * List of Retrievals
  * By Date Range
* Added Consumer API support:
  * Create
  * Retrieve
  * Update
  * Disable
  * Enable
  * Get Consumer Cards
* Added PayU transaction request support
* Added Post Finance transaction request support
* Added SafetyPay transaction request support
* Added TrustlySale transaction request support
* Added MyBank transaction request support
* Added InstaDebit transaction request support
* Added UPI transaction request support
* Added Sofort transaction request support
* Added Multibanco transaction request support

0.2.3
-----
**Features**:

* Added Billing API Support
* Added Alipay transaction request support
* Added the following SDD (Sepa Direct Debit) transaction requests support
  * SDD Sale
  * SDD Init Recurring Sale
  * SDD Refund
  * SDD Recurring Sale
* Added Spei payment type support to Online Banking PayIn
* Added EPS transaction request support
* Added WeChat transaction request support
* Added Banco Do Brasil transaction request support
* Added iDebit PayIn and PayOut transaction requests support

0.2.2
-----
**Features**:

* Added Installments API services support
* Added Installments attributes support to the following transaction requests:
  * Authorize
  * Authorize 3D
  * Capture
  * Sale
  * Sale 3D
  * Refund
* Added Level 3 Travel Data attributes support to Refund transaction request

0.2.1
-----
**Features**:

* Added Online Banking PayOut transaction request
* Added Funding Parameters support to Google Pay and Apple Pay transaction requests
* Added Bancontact transaction request support
* Added Cash transaction request support
* Added COF and UCOF parameters support to the following transaction requests:
  * Authorize
  * Authorize 3D
  * Sale
  * Sale 3D
* Added Tokenized e-commerce payment support

0.2.0
-----
**Features**:

* Added Funding parameters support to the following transaction requests:
  * Authorize
  * Authorize 3D
  * Sale
  * Sale 3D
  * Web Payment Form
* Added Dynamic Descriptor geo coordinates support
* Added POLI bank code and NZD currency support to Online Banking PayIn transaction request
* Added recurring type parameter support to Google Pay and Apple Pay transaction requests

0.1.9
-----
**Features**:

* Added PayPal transaction request
* Added PIX transaction request
* Added Boleto transaction request
* Added Neighborhood parameter support to Billing and Shipping address attributes
* Added Argencard transaction request
* Added Aura transaction request
* Added Baloto transaction request
* Added Banco de Occidente transaction request
* Added Bancomer transaction request
* Added Bradesco transaction request
* Added Cabal transaction request
* Added Cencosud transaction request
* Added Davivienda transaction request
* Added Efecty transaction request
* Added Elo transaction request
* Added Itau transaction request
* Added Naranja transaction request
* Added Nativa transaction request
* Added OXXO transaction request
* Added Pago Facil transaction request
* Added PSE transaction request
* Added RapiPago transaction request
* Added Redpagos transaction request
* Added Santander transaction request
* Added Tarjeta Shopping transaction request
* Added Webpay transaction request

0.1.8
-----
**Features**:

* Added Apple Pay transaction request support
* Added Google Pay transaction request support
* Added Online Banking PayIn transaction request support
* Updated transform amount logic during request execution
* Added 3DSv2 parameters validations

0.1.7
-----
**Features**:

* Removed GiroPay transaction type support through the Web Payment Form
* Added Protocol Sub Version parameter support part of the MPI attributes
* Added Level 3 Travel Data attributes support to the following transaction requests:
  * Sale
  * Sale 3D
  * Authorize
  * Authorize 3D
  * Init Recurring Sale
  * Init Recurring Sale 3D
  * RecurringSale
  * Capture

0.1.6
-----
**Features**:

* Added Web Payment Form `lifetime` validations with a maximum allowed value of 3 months in minutes (131487)
* Added Web Payment Form `lifetime` default value of 30 minutes
* Added Web Payment Form Reminders support
* Added Pay Later parameter support to the Web Payment Form
  * Reminders will be sent to the Gateway only when `pay_later=true`
* Added Reminder Language parameter support to the Web Payment Form. It accepts only available WPF locales.
* Added validation for Web Payment Form `locale` attribute. It accepts only available WPF locales.

0.1.5
-----
**Features**:

* Added Smart Routing support
* Added Required field validations to the existing transaction requests

**Fixes**:

* Fixed JSON parser loading in the Response handling logic

0.1.4
-----
**Features**:

* Added Account Owner attributes support to the following transaction requests:
  * Authorize
  * Authorize 3D
  * Sale
  * Sale 3D
  * Web Payment Form
* Added MPI attributes support to the following transaction requests:
  * Authorize 3D
  * Sale 3D
* Removed Recurring Type attribute from Web Payment Form transaction request
* Added Managed Recurring attributes support to the following transaction requests:
  * Authorize
  * Authorize 3D
  * Sale
  * Sale 3D

0.1.3
-----
**Fixes**:

* Fixed 3DSv2 Method element name in the XML document

0.1.2
-----
**Features**:

* Added 3D Secure Method Continue API request support
* Updated Gateway response handling upon error cases like 3D Secure Method Continue with invalid identifier a Network error will be raised
* Added `GenesisRuby::Api::Notification` handler that provides an easy way of handling Gateway instant payment notifications

0.1.1
-----
**Features**:

* Added request support for the following transaction reference actions:
  * Capture
  * Void
  * Refund
* Added support for the following Reconcile API requests:
  * Transaction
  * By Date Range
  * Web Payment Form Reconcile
* Added Documentation URI to the project metadata description

**Fixes**:

* Fixed response parser handling with attributes inside the root element
* Fixed Changelog URI in the project metadata description

0.1.0
-----
**Features**:

* Added initial Genesis Client Library version 0.1.0
* Added support for the creation of the following transaction requests:
    * Web Payment Form
    * Authorize
    * Authorize 3D
    * Sale
    * Sale 3D
