module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module CashPayments
            # Cash Payment Types allowed values
            class CashPaymentTypes

              extend Mixins::Constants::Common

              # 7 Eleven
              SEVEN_ELEVEN             = 'seven_eleven'.freeze

              # Bancomer
              BANCOMER                 = 'bancomer'.freeze

              # Farmacias del Dr. Ahorro
              PHARMACIES_DEL_DR_AHORRO = 'pharmacies_del_dr_ahorro'.freeze

              # Farmacias Santa Maria
              PHARMACIES_SANTA_MARIA   = 'pharmacies_santa_maria'.freeze

              # OXXO
              OXXO                     = 'oxxo'.freeze

              # Scotiabank
              SCOTIABANK               = 'scotiabank'.freeze

            end
          end
        end
      end
    end
  end
end
