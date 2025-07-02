# frozen_string_literal: true

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
              SEVEN_ELEVEN             = 'seven_eleven'

              # Bancomer
              BANCOMER                 = 'bancomer'

              # Farmacias del Dr. Ahorro
              PHARMACIES_DEL_DR_AHORRO = 'pharmacies_del_dr_ahorro'

              # Farmacias Santa Maria
              PHARMACIES_SANTA_MARIA   = 'pharmacies_santa_maria'

              # OXXO
              OXXO                     = 'oxxo'

              # Scotiabank
              SCOTIABANK               = 'scotiabank'

            end
          end
        end
      end
    end
  end
end
