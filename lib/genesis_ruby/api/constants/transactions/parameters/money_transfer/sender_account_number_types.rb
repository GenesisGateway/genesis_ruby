# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module MoneyTransfer
            # Money Transfer Sender Account Number Types
            class SenderAccountNumberTypes

              extend Mixins::Constants::Common

              # RTN and bank account number
              RTN_AND_BANK_ACCOUNT_NUMBER = 'rtn_and_bank_account_number'

              # International Bank Account Number
              IBAN                        = 'iban'

              # Card account
              CARD_ACCOUNT                = 'card_account'

              # Email
              EMAIL                       = 'email'

              # Phone number
              PHONE_NUMBER                = 'phone_number'

              # Bank account number and Bank Identification Code
              BANK_ACCOUNT_NUMBER_AND_BIC = 'bank_account_number_and_bic'

              # Wallet ID
              WALLET_ID                   = 'wallet_id'

              # Social network ID
              SOCIAL_NETWORK_ID           = 'social_network_id'

              # Other
              OTHER                       = 'other'

            end
          end
        end
      end
    end
  end
end
