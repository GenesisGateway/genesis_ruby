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
              BANK_TO_BANK     = 'bank_to_bank'.freeze

              # PIX
              PIX              = 'pix'.freeze

              # BSB
              BSB              = 'bsb'.freeze

              # Pay ID
              PAY_ID           = 'pay_id'.freeze

              # Bank to Bank, Business to Business
              BANK_TO_BANK_B2B = 'bank_to_bank_b2b'.freeze

              # PIX Business to Business
              PIX_B2B          = 'pix_b2b'.freeze

              # Clabe
              CLABE            = 'clabe'.freeze

              # Cellphone
              CELLPHONE        = 'cellphone'.freeze

            end
          end
        end
      end
    end
  end
end
