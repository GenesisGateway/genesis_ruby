# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module Wallets
            module EWallet
              # eWallet allowed payment types (e-wallet provider names, sent verbatim to the gateway)
              class PaymentTypes

                extend Api::Mixins::Constants::Common

                # Airtel Money e-wallet provider
                AIRTEL_MONEY = 'Airtel Money'

                # Amazon pay e-wallet provider
                AMAZON_PAY   = 'Amazon pay'

                # Free Charge e-wallet provider
                FREE_CHARGE  = 'Free Charge'

                # Jio Money e-wallet provider
                JIO_MONEY    = 'Jio Money'

                # Ola Money e-wallet provider
                OLA_MONEY    = 'Ola Money'

                # Paytm e-wallet provider
                PAYTM        = 'Paytm'

                # Payzapp e-wallet provider
                PAYZAPP      = 'Payzapp'

                # PhonePe e-wallet provider
                PHONE_PE     = 'PhonePe'

              end
            end
          end
        end
      end
    end
  end
end
