# frozen_string_literal: true

module GenesisRuby
  module Utils
    module Transactions
      # Web Payment Form Transaction Types Helper methods
      class WpfTypes

        class << self

          include GenesisRuby::Api::Constants::Transactions

          # Return array containing all available Web Payment Form transaction types
          def all # rubocop:disable Metrics/MethodLength
            [
              ACCOUNT_VERIFICATION, ALIPAY, ARGENCARD, APPLE_PAY, AURA, AUTHORIZE, AUTHORIZE_3D,
              BALOTO, BANCOMER, BANCONTACT, BANCO_DE_OCCIDENTE, BITPAY_PAYOUT, BITPAY_SALE, BOLETO,
              CABAL, CASHU, CENCOSUD, DAVIVIENDA,
              EFECTY, ELO, EPS, EZEEWALLET, FASHIONCHEQUE,
              GOOGLE_PAY,
              IDEAL, IDEBIT_PAYIN, INSTA_DEBIT_PAYIN, INTERSOLVE,
              MULTIBANCO, MY_BANK,
              NARANJA, NATIVA, NEOSURF, NETELLER,
              ONLINE_BANKING_PAYIN, OXXO,
              P24, PAGO_FACIL, PAY_PAL, PAYSAFECARD, PAYU, PIX, POLI, POST_FINANCE, PPRO,
              RAPI_PAGO, RUSSIAN_MOBILE_SALE,
              SAFETYPAY, SALE, SALE_3D, SDD_INIT_RECURRING_SALE, SDD_SALE,
              TARJETA_SHOPPING, TCS, TRUSTLY_SALE,
              UPI,
              WEBMONEY, WECHAT
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
