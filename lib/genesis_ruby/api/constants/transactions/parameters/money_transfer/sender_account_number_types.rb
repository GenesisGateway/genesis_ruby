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

              # International Bank Account Number
              IBAN                         = 'iban'

              # Credit/Debit card account number
              CREDIT_DEBIT_CARD            = 'credit_debit_card'

              # Savings/Checking/Investment account number
              SAVINGS_CHECKING_INVESTMENT  = 'savings_checking_investment'

              # Social Networking ID
              SOCIAL_NETWORKING_ID         = 'social_networking_id'

              # Phone number
              PHONE_NUMBER                 = 'phone_number'

              # Bank account number and Bank Identification Code
              BANK_ACCOUNT_NUMBER_AND_BIC  = 'bank_account_number_and_bic'

              # Wallet ID
              WALLET_ID                    = 'wallet_id'

              # Unique transaction reference
              UNIQUE_TRANSACTION_REFERENCE = 'unique_transaction_reference'

              # National ID
              NATIONAL_ID                  = 'national_id'

              # Other
              OTHER                        = 'other'

            end
          end
        end
      end
    end
  end
end
