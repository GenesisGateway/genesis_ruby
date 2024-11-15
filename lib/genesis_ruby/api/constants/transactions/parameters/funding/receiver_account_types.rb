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
              RTN_AND_BANK_ACCOUNT_NUMBER = 'rtn_and_bank_account_number'.freeze

              # International Bank Account Number
              IBAN                        = 'iban'.freeze

              # Card Account
              CARD_ACCOUNT                = 'card_account'.freeze

              # Electronic Mail
              EMAIL                       = 'email'.freeze

              # Phone Number
              PHONE_NUMBER                = 'phone_number'.freeze

              # Bank Account Number and Business Identifier Code
              BANK_ACCOUNT_NUMBER_AND_BIC = 'bank_account_number_and_bic'.freeze

              # Wallet ID
              WALLET_ID                   = 'wallet_id'.freeze

              # Unique Identifier for Social Network Application
              SOCIAL_NETWORK_ID           = 'social_network_id'.freeze

              # Any other type
              OTHER                       = 'other'.freeze

            end
          end
        end
      end
    end
  end
end
