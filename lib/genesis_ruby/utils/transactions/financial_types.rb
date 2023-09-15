module GenesisRuby
  module Utils
    module Transactions
      # Financial Transaction Types Helper methods
      class FinancialTypes

        class << self

          include GenesisRuby::Api::Constants::Transactions

          # Return array containing all available Web Payment Form transaction types
          def all # rubocop:disable Metrics/MethodLength
            [
              AFRICAN_MOBILE_PAYOUT, AFRICAN_MOBILE_SALE, APPLE_PAY, ARGENCARD, AURA, AUTHORIZE, AUTHORIZE_3D,
              BALOTO, BANCOMER, BANCONTACT, BANCO_DE_OCCIDENTE, BANCO_DO_BRASIL, BITPAY_PAYOUT, BITPAY_REFUND,
              BITPAY_SALE, BOLETO, BRADESCO,
              CABAL, CAPTURE, CASHU, CENCOSUD, CREDIT,
              DAVIVIENDA,
              EFECTY, ELO, EPS,
              EZEECARD_PAYOUT, EZEEWALLET,
              FASHIONCHEQUE,
              GIROPAY, GOOGLE_PAY,
              IDEAL, IDEBIT_PAYIN, IDEBIT_PAYOUT, INCREMENTAL_AUTHORIZE, INSTA_DEBIT_PAYIN, INSTA_DEBIT_PAYOUT,
              INTERSOLVE, ITAU,
              MULTIBANCO, MY_BANK,
              NARANJA, NATIVA, NEOSURF, NETELLER,
              ONLINE_BANKING_PAYIN, ONLINE_BANKING_PAYOUT,
              OXXO,
              P24, PAGO_FACIL, PARTIAL_REVERSAL, PAYOUT, PAYSAFECARD, PAYU, PAY_PAL, PIX, POLI, POST_FINANCE, PPRO, PSE,
              RAPI_PAGO, REDPAGOS, REFUND, RUSSIAN_MOBILE_PAYOUT, RUSSIAN_MOBILE_SALE,
              SAFETYPAY, SALE, SALE_3D, SANTANDER, SCT_PAYOUT, SDD_INIT_RECURRING_SALE, SDD_RECURRING_SALE, SDD_REFUND,
              SDD_SALE, SOFORT,
              TARJETA_SHOPPING, TCS, TRANSFER_TO_PAYOUT, TRUSTLY_SALE,
              UPI,
              VOID,
              WEBMONEY, WEBPAY, WECHAT
            ]
          end

          # Validates the given type against the available Web Payment Form transaction types
          def valid?(type)
            all.include? type.to_s.downcase
          end

        end

      end
    end
  end
end
