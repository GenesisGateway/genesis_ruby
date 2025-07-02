# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module NonFinancial
        module Kyc
          # Supported types of addresses that can be verified
          class AddressSupportedTypes

            extend Mixins::Constants::Common

            # ID Card
            ID_CARD                    = 'id_card'

            # Passport
            PASSPORT                   = 'passport'

            # Driving license
            DRIVING_LICENSE            = 'driving_license'

            # Utility bill
            UTILITY_BILL               = 'utility_bill'

            # Bank statement
            BANK_STATEMENT             = 'bank_statement'

            # Rent agreement
            RENT_AGREEMENT             = 'rent_agreement'

            # Employer letter
            EMPLOYER_LETTER            = 'employer_letter'

            # Insurance agreement
            INSURANCE_AGREEMENT        = 'insurance_agreement'

            # Tax bill
            TAX_BILL                   = 'tax_bill'

            # Envelope
            ENVELOPE                   = 'envelope'

            # CPR Smart card reader copy
            CPR_SMART_CARD_READER_COPY = 'cpr_smart_card_reader_copy'

          end
        end
      end
    end
  end
end
