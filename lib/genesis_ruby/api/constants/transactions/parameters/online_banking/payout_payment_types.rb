# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module OnlineBanking
            # Bank Payout Payment Types allowed values
            class PayoutPaymentTypes

              extend Api::Mixins::Constants::Common

              # Bank to Bank
              BANK_TO_BANK     = 'bank_to_bank'

              # PIX
              PIX              = 'pix'

              # BSB
              BSB              = 'bsb'

              # Pay ID
              PAY_ID           = 'pay_id'

              # Bank to Bank, Business to Business
              BANK_TO_BANK_B2B = 'bank_to_bank_b2b'

              # PIX Business to Business
              PIX_B2B          = 'pix_b2b'

              # Clabe
              CLABE            = 'clabe'

              # Cellphone
              CELLPHONE        = 'cellphone'

            end
          end
        end
      end
    end
  end
end
