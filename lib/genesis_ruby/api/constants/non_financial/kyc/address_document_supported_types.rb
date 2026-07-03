# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module NonFinancial
        module Kyc
          # Supported document types for address verification by document proof
          class AddressDocumentSupportedTypes

            extend Mixins::Constants::Common

            # ID Card
            ID_CARD = 'id_card'

            # Passport
            PASSPORT = 'passport'

            # Driving license
            DRIVING_LICENSE = 'driving_license'

            # Utility bill
            UTILITY_BILL = 'utility_bill'

            # Bank statement
            BANK_STATEMENT = 'bank_statement'

            # Rent agreement
            RENT_AGREEMENT = 'rent_agreement'

            # Employer letter
            EMPLOYER_LETTER = 'employer_letter'

            # Insurance agreement
            INSURANCE_AGREEMENT = 'insurance_agreement'

            # Tax bill
            TAX_BILL = 'tax_bill'

            # Envelope
            ENVELOPE = 'envelope'

            # CPR Smart card reader copy
            CPR_SMART_CARD_READER_COPY = 'cpr_smart_card_reader_copy'

            # Property tax
            PROPERTY_TAX = 'property_tax'

            # Lease agreement
            LEASE_AGREEMENT = 'lease_agreement'

            # Insurance card
            INSURANCE_CARD = 'insurance_card'

            # Permanent residence permit
            PERMANENT_RESIDENCE_PERMIT = 'permanent_residence_permit'

            # Credit card statement
            CREDIT_CARD_STATEMENT = 'credit_card_statement'

            # Insurance policy
            INSURANCE_POLICY = 'insurance_policy'

            # E-commerce receipt
            E_COMMERCE_RECEIPT = 'e_commerce_receipt'

            # Bank letter receipt
            BANK_LETTER_RECEIPT = 'bank_letter_receipt'

            # Birth certificate
            BIRTH_CERTIFICATE = 'birth_certificate'

            # Salary slip
            SALARY_SLIP = 'salary_slip'

          end
        end
      end
    end
  end
end
