module GenesisRuby
  module Utils
    module Transactions
      module References
        # Refundable Transaction Types Helper Methods
        class RefundableTypes

          class << self

            include GenesisRuby::Api::Constants::Transactions

            # Array containing all available Refundable Types
            def all # rubocop:disable Metrics/MethodLength
              [
                AFRICAN_MOBILE_PAYOUT, AFRICAN_MOBILE_SALE, APPLE_PAY,
                BALOTO, BANCOMER, BANCONTACT, BANCO_DE_OCCIDENTE, BANCO_DO_BRASIL, BITPAY_SALE, BOLETO, BRADESCO,
                CAPTURE, CASHU,
                DAVIVIENDA,
                EFECTY, EPS, FASHIONCHEQUE,
                GOOGLE_PAY,
                IDEAL, IDEBIT_PAYIN, INIT_RECURRING_SALE, INIT_RECURRING_SALE_3D, INVOICE_CAPTURE, ITAU,
                MY_BANK,
                NEOSURF,
                ONLINE_BANKING_PAYIN, OXXO,
                P24, PAGO_FACIL, PARTIAL_REVERSAL, PAYU, PAY_PAL, PIX, POST_FINANCE, PPRO, PSE, RAPI_PAGO,
                RECURRING_SALE, REDPAGOS,
                SAFETYPAY, SALE, SALE_3D, SANTANDER, SDD_INIT_RECURRING_SALE, SDD_RECURRING_SALE, SDD_SALE, SOFORT,
                TRUSTLY_SALE,
                UPI,
                WEBPAY, WECHAT
              ]
            end

            # Checks if the given type is allowed for the execution of Reference Refund Transaction Type
            def allowed_reference?(type)
              all.include?(type.to_s.downcase)
            end

            # Checks if the given type is a Refund type
            def valid?(type)
              [
                BITPAY_REFUND,
                INVOICE_REFUND,
                REFUND,
                SDD_REFUND
              ].include?(type.to_s.downcase)
            end

            # Fetches the correct Transaction type that must be used for the execution of the Refund
            # ex. sdd_sale -> sdd_refund, sale -> refund
            def fetch_reference(type)
              case type.to_s.downcase
              when BITPAY_SALE
                BITPAY_REFUND
              when SDD_SALE, SDD_RECURRING_SALE, SDD_INIT_RECURRING_SALE
                SDD_REFUND
              when INVOICE_CAPTURE
                INVOICE_REFUND
              else
                REFUND
              end
            end

          end

        end
      end
    end
  end
end
