module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module Funding
            # Funding Identifier Types allowed values
            class IdentifierTypes

              extend Api::Mixins::Constants::Common

              # Required MCCs - 4829, 6538, 6540
              GENERAL_PERSON_TO_PERSON              = 'general_person_to_person'.freeze

              # Required MCCs - 4829
              PERSON_TO_PERSON_CARD_ACCOUNT         = 'person_to_person_card_account'.freeze

              # Required MCCs - 4829, 6051, 6211, 6538, 6540, 7800, 7801, 7802, 7994, 7995, 9406
              OWN_ACCOUNT                           = 'own_account'.freeze

              # Required MCCs - 4829, 6538
              OWN_CREDIT_CARD_BILL                  = 'own_credit_card_bill'.freeze

              # Required MCCs - any
              BUSINESS_DISBURSEMENT                 = 'business_disbursement'.freeze

              # Required MCCs - any
              GOVERNMENT_OR_NON_PROFIT_DISBURSEMENT = 'government_or_non_profit_disbursement'.freeze

              # Required MCCs - any
              RAPID_MERCHANT_SETTLEMENT             = 'rapid_merchant_settlement'.freeze

              # Required MCCs - any
              GENERAL_BUSINESS_TO_BUSINESS          = 'general_business_to_business'.freeze

              # Required MCCs - any
              OWN_STAGED_DIGITAL_WALLET_ACCOUNT     = 'own_staged_digital_wallet_account'.freeze

              # Required MCCs - any
              OWN_DEBIT_OR_PREPAID_CARD_ACCOUNT     = 'own_debit_or_prepaid_card_account'.freeze

            end
          end
        end
      end
    end
  end
end
