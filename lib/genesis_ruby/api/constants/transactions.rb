require 'genesis_ruby/api/mixins/constants/common'

module GenesisRuby
  module Api
    module Constants
      # Available Transaction Types definitions
      module Transactions

        extend Mixins::Constants::Common

        # Account Verification
        ACCOUNT_VERIFICATION = 'account_verification'.freeze

        # African Mobile Payout, or otherwise known as Disbursement, is an APM used to process Mobile network operator
        # payments. It is an async payment method and will be approved once the payment is processed with the Mobile
        # network operator
        AFRICAN_MOBILE_PAYOUT = 'african_mobile_payout'.freeze

        # African Mobile Sale, otherwise known as Charge, is an APM used to process Mobile network operator payments.
        # It is an async payment method and will be approved once the payment is processed with the Mobile network
        # operator
        AFRICAN_MOBILE_SALE = 'african_mobile_sale'.freeze

        # Apple pay is payment method working with apple devices
        APPLE_PAY = 'apple_pay'.freeze

        # Argencard is a debit or credit card used in Argentina. It allows online shoppers to pay offline
        # for their online purchases at over 150,000 physical outlets.
        ARGENCARD = 'argencard'.freeze

        # Aura is a local Brazilian credit card.
        AURA = 'aura'.freeze

        # A standard Authorization
        AUTHORIZE = 'authorize'.freeze

        # 3D-Secure Authorization
        AUTHORIZE_3D = 'authorize3d'.freeze

        # Baloto is a cash payment option in Colombia. It allows the customers to receive a voucher at check-out.
        # The voucher can then be paid in any of the Via Boleto offices in cash.
        BALOTO = 'baloto'.freeze

        # Bancomer offers two options for payments in Mexico, cash payment and bank transfer.
        BANCOMER = 'bancomer'.freeze

        # Bancontact is a local Belgian debit card scheme.
        # All Belgian debit cards are co-branded Bancontact and Maestro.
        BANCONTACT = 'bcmc'.freeze

        # Banco de Occidente is a cash payment method for Colombia
        BANCO_DE_OCCIDENTE = 'banco_de_occidente'.freeze

        # Banco do Brasil offers online bank transfer payment service.
        BANCO_DO_BRASIL = 'banco_do_brasil'.freeze

        # BitPay Payout is a crypto currency payout method where merchants are requesting
        # payouts in FIAT currency and the funds are transfered in Bitcoin equivalent to a crypto wallet address.
        BITPAY_PAYOUT = 'bitpay_payout'.freeze

        # BitPay Refund is a custom refund method which will handle the asynchronous BitPay refund workflow.
        # BitPay refunds can only be done on former transactions. Therefore, the reference id for the
        # corresponding BitPay Sale transaction is mandatory.
        BITPAY_REFUND = 'bitpay_refund'.freeze

        # BitPay is a cryptocurrency payments provider supporting blockchain payments
        # with Bitcoin (BTC) and BitcoinCash (BCH).
        BITPAY_SALE = 'bitpay_sale'.freeze

        # Boleto is a payment service in Brazil
        BOLETO = 'boleto'.freeze

        # Bradesco is a payment service in Brazil
        BRADESCO = 'bradesco'.freeze

        # Cabal is a local debit/credit card brand in Argentina which can be used for online purchases.
        CABAL = 'cabal'.freeze

        # Capture settles a transaction which has been authorized before.
        CAPTURE = 'capture'.freeze

        # Voucher-based payment
        CASHU = 'cashu'.freeze

        # Cencosud is a local credit card in Argentina
        CENCOSUD = 'cencosud'.freeze

        # Credits (also known as Credit Fund Transfer a.k.a. CFT)
        CREDIT = 'credit'.freeze

        # Davivienda is offering the Bill pay service which is a fast, easy and secure way to pay and manage
        # your bills online to anyone, anytime in Colombia.
        DAVIVIENDA = 'davivienda'.freeze

        # Efecty is an offline cash payment voucher option in Colombia.
        EFECTY = 'efecty'.freeze

        # Elo is a local Brazilian payment card.
        ELO = 'elo'.freeze

        # e-payment standard
        # Direct PPRO transaction
        EPS = 'eps'.freeze

        # eZeeCard Payout is a sync based payout method.
        # It's merchant initiated and can only reference specific transaction types
        EZEECARD_PAYOUT = 'ezeecard_payout'.freeze

        # Wallet-based payment
        EZEEWALLET = 'ezeewallet'.freeze

        # Fashioncheque transactions are made using gift card provided by Fashioncheque.
        # Using a fashioncheque transaction, the amount is immediately billed to the customer’s gift card.
        # It can be reversed via a void transaction on the same day of the transaction.
        # They can also be refunded.
        FASHIONCHEQUE = 'fashioncheque'.freeze

        # Google Pay allows shoppers to purchase with credit and debit cards linked to their Google account.
        GOOGLE_PAY = 'google_pay'.freeze

        # iDEAL
        # Direct PPRO transaction
        IDEAL = 'ideal'.freeze

        # iDebit connects consumers to their online banking directly from checkout, enabling secure,
        # real-time payments without a credit card.
        # Using iDebit allows consumers to transfer funds to merchants without
        # revealing their personal banking information.
        # iDebit Payin is only asynchronous and uses eCheck.
        IDEBIT_PAYIN = 'idebit_payin'.freeze

        # iDebit connects consumers to their online banking directly from checkout, enabling secure,
        # real-time payments without a credit card.
        # Using iDebit allows consumers to transfer funds to merchants without
        # revealing their personal banking information.
        # iDebit Payout is only synchronous and uses eCheck.
        IDEBIT_PAYOUT = 'idebit_payout'.freeze

        # Incremental authorizations are used in preauthorization workflow to extend the preauthorization amount,
        # extend the preauthorization time-frame
        INCREMENTAL_AUTHORIZE = 'incremental_authorize'.freeze

        # A standard initial recurring
        # @deprecated Since 0.1.0 Payment method is deprecated and will be removed
        INIT_RECURRING_SALE = 'init_recurring_sale'.freeze

        # 3D-based initial recurring
        # @deprecated Since 0.1.0 Payment method is deprecated and will be removed
        INIT_RECURRING_SALE_3D = 'init_recurring_sale3d'.freeze

        # InstaDebit connects consumers to their online banking directly from checkout, enabling secure,
        # real- time payments without a credit card.
        # Using InstaDebit allows consumers to transfer funds to merchants without
        # revealing their personal banking information.
        # InstaDebit Payin is only asynchronous and uses online bank transfer.
        INSTA_DEBIT_PAYIN = 'insta_debit_payin'.freeze

        # InstaDebit connects consumers to their online banking directly from checkout, enabling secure,
        # real- time payments without a credit card.
        # Using InstaDebit allows consumers to transfer funds to merchants without
        # revealing their personal banking information.
        # InstaDebit Payout is only synchronous and uses online bank transfer.
        INSTA_DEBIT_PAYOUT = 'insta_debit_payout'.freeze

        # Intersolve transactions are made using gift card provided by Intersolve
        # Using a intersolve transaction, the amount is immediately billed to the customer’s gift card.
        # It can be reversed via a void transaction.
        INTERSOLVE = 'intersolve'.freeze

        # Alternative payments refer to payment methods that are used as an alternative to credit card payments.
        # Each alternative payment method has its own unique application, settlement process and currency support.
        INVOICE = 'invoice'.freeze

        # A Invoice capture can only be used after a Invoice on the same transaction.
        INVOICE_CAPTURE = 'invoice_capture'.freeze

        # The amount can be fully or partially refunded. Invoice refunds can only be done on former
        # Invoice Capture (settled) transactions.
        INVOICE_REFUND = 'invoice_refund'.freeze

        # Itau is a real-time online bank transfer method and a virtual card.
        ITAU = 'itau'.freeze

        # Multibanco allows Portuguese shoppers to do payments through the Internet by using virtual credit cards
        MULTIBANCO = 'multibanco'.freeze

        # My Bank is an overlay banking system
        MY_BANK = 'my_bank'.freeze

        # Naranja is a local credit card issued in Argentina which can be used for purchases over the internet.
        NARANJA = 'naranja'.freeze

        # Nativa is an Argentinian credit card provided by the National Bank of Argentina.
        NATIVA = 'nativa'.freeze

        # Neosurf is a prepaid card (voucher) that is used for online shopping. The card is available in over 100,000
        # stores worldwide, where customers can buy the prepaid vouchers, denominated up to EUR 250.00 or
        # its equivalent in other currencies.
        NEOSURF = 'neosurf'.freeze

        # Neteller
        NETELLER = 'neteller'.freeze

        # Online Banking is an oBeP-style alternative payment method that allows you to pay directly
        # with your ebank account. After initiating a transaction, the online banking will redirect you to their page.
        # There you will find a list with available banks to finish the payment.
        ONLINE_BANKING_PAYIN = 'online_banking'.freeze

        # Bank Pay-out is a bank pay-out method. It allows merchants to transfer funds directly to customers’
        # bank accounts.
        ONLINE_BANKING_PAYOUT = 'bank_payout'.freeze

        # OXXO is the preferred payment method in Mexico. It is a cash payment via a barcode document
        # thats accepted in more than 14,000 stores.
        OXXO = 'oxxo'.freeze

        # P24 is an online banking payment, popular in Poland
        P24 = 'p24'.freeze

        # Pago Facil is a payment service in Argentina that allows its users to send money,
        # top up their cell phone and payments.
        PAGO_FACIL = 'pago_facil'.freeze

        # Partial reversal transactions are used in preauthorization workflow to release a part of the
        # total authorized amount before a partial capture to be submitted. A transaction of this type
        # should refer the preauthorization directly.
        PARTIAL_REVERSAL = 'partial_reversal'.freeze

        # PayByVouchers via oBeP
        # @deprecated Payment method is deprecated and will be removed
        PAYBYVOUCHER_YEEPAY = 'paybyvoucher_yeepay'.freeze

        # Payouts transactions
        PAYOUT = 'payout'.freeze

        # Voucher-based payment
        PAYSAFECARD = 'paysafecard'.freeze

        # PayU is a payment method for Czech Republic and Poland
        PAYU = 'payu'.freeze

        # PayPal transaction is a fast and easy way for buyers to pay with their PayPal account.
        # It gives buyers all the transaction details at once, including order details, shipping options,
        # insurance choices, and tax totals.
        PAY_PAL = 'pay_pal'.freeze

        # Pix is a payment service created by the Central Bank of Brazil (BACEN),
        # which represents a new way of receiving/sending money. Pix allows payments
        # to be made instantly. The customer can pay bills, invoices, public utilities,
        # transfer and receive credits in a facilitated manner, using only Pix keys (CPF/CNPJ).
        PIX = 'pix'.freeze

        # POLi is Australia's most popular online real time debit payment system.
        POLI = 'poli'.freeze

        # PostFinance is an online banking provider in Switzerland
        POST_FINANCE = 'post_finance'.freeze

        # Supports payments via EPS, SafetyPay, TrustPay, ELV, Przelewy24
        PPRO = 'ppro'.freeze

        # PSE (Pagos Seguros en Linea) is the preferred alternative payment solution in Colombia.
        # The solution consists of an interface that offers the client the option to pay for their online purchases
        # in cash, directing it to their online banking.
        PSE = 'pse'.freeze

        # RapiPago from Argentina is an offline payment method used for online purchases.
        # Shoppers buy their goods and services online and pay offline at one of the 6,000+ RapiPago
        # payment locations.
        RAPI_PAGO = 'rapi_pago'.freeze

        # A RecurringSale transaction is a "repeated" transaction which follows and references an initial transaction
        # @deprecated Since 0.1.0 Payment method is deprecated and will be removed
        RECURRING_SALE = 'recurring_sale'.freeze

        # Redpagos is a cash payment in Uruguay
        REDPAGOS = 'redpagos'.freeze

        # Refunds allow to return already billed amounts to customers.
        REFUND = 'refund'.freeze

        # Russian Mobile Payout, or otherwise known as Disbursement, is an APM used to process Mobile network operator
        # payments. It is an async payment method and will be approved once the payment is processed by the
        # Mobile network operator. Notice: Russian Mobile Payout does not support refund and void.
        RUSSIAN_MOBILE_PAYOUT = 'russian_mobile_payout'.freeze

        # Russian Mobile Sale, otherwise known as Charge, is an APM used to process Mobile network operator payments.
        # It is an async payment method and will be approved once the payment is processed by the Mobile network
        # operator.
        # Notice: Russian Mobile Sale does not support refund and void.
        RUSSIAN_MOBILE_SALE = 'russian_mobile_sale'.freeze

        # Safetypay is a real-time bank transfer system that operates in more than 10 different countries.
        # Their main market is in Latin America.
        SAFETYPAY = 'safetypay'.freeze

        # A standard Sale
        SALE = 'sale'.freeze

        # 3D-Secure Sale
        SALE_3D = 'sale3d'.freeze

        # Santander is an online bank transfer for ecommerce purchases. Consumers use their trusted home
        # banking environment, merchants benefit from payment guarantee and swift settlement.
        SANTANDER = 'santander'.freeze

        # Sepa Direct Debit Payout, popular in Germany.
        # Processed as a SEPA CreditTransfer and can be used for all kind of payout services across the EU with 1 day
        # settlement. Suitable for Gaming, Forex-Binaries, Affiliate Programs or Merchant payouts
        SCT_PAYOUT = 'sct_payout'.freeze

        # Sepa Direct Debit initial recurring
        SDD_INIT_RECURRING_SALE = 'sdd_init_recurring_sale'.freeze

        # Sepa Direct Debit RecurringSale transaction is a "repeated" transaction,
        # which follows and references an SDD initial transaction
        SDD_RECURRING_SALE = 'sdd_recurring_sale'.freeze

        # Sepa Direct Debit Refund Transaction.
        # Refunds allow to return already billed amounts to customers.
        SDD_REFUND = 'sdd_refund'.freeze

        # Sepa Direct Debit Payment, popular in Germany.
        # Single Euro Payments Area (SEPA) allows consumers to make cashless Euro payments to
        # any beneficiary located anywhere in the Euro area using only a single bank account
        SDD_SALE = 'sdd_sale'.freeze

        # Bank transfer payment, popular in Germany
        SOFORT = 'sofort'.freeze

        # Tarjeta Shopping is a cash payment in Argentina.
        TARJETA_SHOPPING = 'tarjeta_shopping'.freeze

        # TCS Thecontainerstore transactions are made using gift cards provided by TCS The amount from a
        # Container Store Transactions is immediately billed to the customer’s gift card.
        # It can be reversed via a void transaction.
        TCS = 'container_store'.freeze

        # TransferTo Payout is an APM which provides 3 different payment services:
        # BankAccount, MobileWallet and CashPickup. Merchant sends money to a consumer.
        TRANSFER_TO_PAYOUT = 'transfer_to_payout'.freeze

        # Trustly is a fast and secure oBeP-style alternative payment method. It is free of charge and
        # allows you to deposit money directly from your online bank account.
        TRUSTLY_SALE = 'trustly_sale'.freeze

        # UPI (Unified Payment Interface) transaction is an alternative payment method
        # which allows users to transfer money between bank accounts.
        UPI = 'upi'.freeze

        # Void transactions undo previous transactions.
        VOID = 'void'.freeze

        # WebMoney is a global settlement system and environment for online business activities.
        WEBMONEY = 'webmoney'.freeze

        # Webpay is a Chilean real-time bank transfer method.
        WEBPAY = 'webpay'.freeze

        # WeChat Pay solution offers merchants access to the over 300 million WeChat users that have linked payment
        # to their WeChat account. The solution works on desktop and mobile via a QR code generation platform.
        WECHAT = 'wechat'.freeze

      end
    end
  end
end
