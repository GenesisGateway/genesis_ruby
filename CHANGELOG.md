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
