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
