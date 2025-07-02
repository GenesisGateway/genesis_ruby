# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module Funding
            # Funding Receiver Account Types allowed values
            class ReceiverAccountTypes

              extend Api::Mixins::Constants::Common

              # Routing Transit Number and Bank Account Number
              RTN_AND_BANK_ACCOUNT_NUMBER = 'rtn_and_bank_account_number'

              # International Bank Account Number
              IBAN                        = 'iban'

              # Card Account
              CARD_ACCOUNT                = 'card_account'

              # Electronic Mail
              EMAIL                       = 'email'

              # Phone Number
              PHONE_NUMBER                = 'phone_number'

              # Bank Account Number and Business Identifier Code
              BANK_ACCOUNT_NUMBER_AND_BIC = 'bank_account_number_and_bic'

              # Wallet ID
              WALLET_ID                   = 'wallet_id'

              # Unique Identifier for Social Network Application
              SOCIAL_NETWORK_ID           = 'social_network_id'

              # Any other type
              OTHER                       = 'other'

            end
          end
        end
      end
    end
  end
end
