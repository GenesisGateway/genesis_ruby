# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module MoneyTransfer
            # Money Transfer Types
            class Types

              extend Mixins::Constants::Common

              # Account to account transfer
              ACCOUNT_TO_ACCOUNT                    = 'account_to_account'

              # Person to person transfer
              PERSON_TO_PERSON                      = 'person_to_person'

              # Wallet transfer
              WALLET_TRANSFER                       = 'wallet_transfer'

              # Funds transfer
              FUNDS_TRANSFER                        = 'funds_transfer'

              # Liquid assets
              LIQUID_ASSETS                         = 'liquid_assets'

              # Merchant settlement
              MERCHANT_SETTLEMENT                   = 'merchant_settlement'

              # Own account
              OWN_ACCOUNT                           = 'own_account'

              # Own credit card bill
              OWN_CREDIT_CARD_BILL                  = 'own_credit_card_bill'

              # Business disbursement
              BUSINESS_DISBURSEMENT                 = 'business_disbursement'

              # Government or non-profit disbursement
              GOVERNMENT_OR_NON_PROFIT_DISBURSEMENT = 'government_or_non_profit_disbursement'

              # General business to business
              GENERAL_BUSINESS_TO_BUSINESS          = 'general_business_to_business'

            end
          end
        end
      end
    end
  end
end
