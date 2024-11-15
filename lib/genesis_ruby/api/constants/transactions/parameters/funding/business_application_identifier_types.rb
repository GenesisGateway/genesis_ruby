module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module Funding
            # Business Application Identifier Types allowed values
            class BusinessApplicationIdentifierTypes

              extend Api::Mixins::Constants::Common

              # Type FUNDS_DISBURSEMENT
              FUNDS_DISBURSEMENT   = 'funds_disbursement'.freeze

              # Type PENSION_DISBURSEMENT
              PENSION_DISBURSEMENT = 'pension_disbursement'.freeze

              # Type ACCOUNT_TO_ACCOUNT
              ACCOUNT_TO_ACCOUNT   = 'account_to_account'.freeze

              # Type BANK_INITIATED
              BANK_INITIATED       = 'bank_initiated'.freeze

              # Type FUND_TRANSFER
              FUND_TRANSFER        = 'fund_transfer'.freeze

              # Type PERSON_TO_PERSON
              PERSON_TO_PERSON     = 'person_to_person'.freeze

              # Type PREPAID_CARD_LOAD
              PREPAID_CARD_LOAD    = 'prepaid_card_load'.freeze

              # Type WALLET_TRANSFER
              WALLET_TRANSFER      = 'wallet_transfer'.freeze

              # Type LIQUID_ASSETS
              LIQUID_ASSETS        = 'liquid_assets'.freeze

            end
          end
        end
      end
    end
  end
end
