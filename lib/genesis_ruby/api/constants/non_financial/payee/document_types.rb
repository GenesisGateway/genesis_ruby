# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module NonFinancial
        module Payee
          # Document Types allowed values
          class DocumentTypes

            extend Mixins::Constants::Common

            # Proof of Identity
            POI = 'poi'

            # Passport
            PASSPORT = 'passport'

            # ID Card
            ID_CARD = 'id_card'

            # Driving License
            DRIVING_LICENSE = 'driving_license'

            # Proof of Address
            POA = 'poa'

            # Utility Bill
            UTILITY_BILL = 'utility_bill'

            # Bank Statement
            BANK_STATEMENT = 'bank_statement'

            # Company Registration
            COMPANY_REGISTRATION = 'company_registration'

            # Tax Return
            TAX_RETURN = 'tax_return'

            # Memorandum of Association
            MEMORANDUM_OF_ASSOCIATION = 'memorandum_of_association'

            # Shareholder Register
            SHAREHOLDER_REGISTER = 'shareholder_register'

            # Board Resolution
            BOARD_RESOLUTION = 'board_resolution'

            # Proof of Address
            PROOF_OF_ADDRESS = 'proof_of_address'

          end
        end
      end
    end
  end
end
