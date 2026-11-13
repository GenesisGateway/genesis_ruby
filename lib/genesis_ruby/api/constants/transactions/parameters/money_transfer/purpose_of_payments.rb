# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module MoneyTransfer
            # Money Transfer Purpose of Payments (Mastercard)
            class PurposeOfPayments

              extend Mixins::Constants::Common

              # Family support
              FAMILY_SUPPORT                             = 'family_support'

              # Regular labor transfers
              REGULAR_LABOR_TRANSFERS                    = 'regular_labor_transfers'

              # Travel and tourism
              TRAVEL_AND_TOURISM                         = 'travel_and_tourism'

              # Hospitalization and medical treatment
              HOSPITALIZATION_AND_MEDICAL_TREATMENT      = 'hospitalization_and_medical_treatment'

              # Emergency need
              EMERGENCY_NEED                             = 'emergency_need'

              # Savings
              SAVINGS                                    = 'savings'

              # Gifts
              GIFTS                                      = 'gifts'

              # Salary
              SALARY                                     = 'salary'

              # Crowd lending
              CROWD_LENDING                              = 'crowd_lending'

              # Crypto currency
              CRYPTO_CURRENCY                            = 'crypto_currency'

              # Refund to original card
              REFUND_TO_ORIGINAL_CARD                    = 'refund_to_original_card'

              # Refund to new card
              REFUND_TO_NEW_CARD                         = 'refund_to_new_card'

              # Transfer to another person or organization in the same staged digital wallet (Brazil)
              SAME_DIGITAL_WALLET_TRANSFER_TO_PERSON_ORG = 'same_digital_wallet_transfer_to_person_org'

              # Boleto payment (Brazil)
              BOLETO_PAYMENT                             = 'boleto_payment'

              # High risk securities
              HIGH_RISK_SECURITIES                       = 'high_risk_securities'

              # Recycling deposit return
              RECYCLING_DEPOSIT                          = 'recycling_deposit'

              # VAT payment
              VAT_PAYMENT                                = 'vat_payment'

              # Education
              EDUCATION                                  = 'education'

              # Other
              OTHER                                      = 'other'

            end
          end
        end
      end
    end
  end
end
