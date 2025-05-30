module GenesisRuby
  module Api
    module Constants
      module NonFinancial
        module Kyc
          # This class provides a mapping of supported document types for KYC procedures.
          class DocumentSupportedTypes

            extend Mixins::Constants::Common

            # Passport document type
            PASSPORT             = 'passport'.freeze

            # ID card document type
            ID_CARD              = 'id_card'.freeze

            # Driving license document type
            DRIVING_LICENSE      = 'driving_license'.freeze

            # Credit or Debit card document type
            CREDIT_OR_DEBIT_CARD = 'credit_or_debit_card'.freeze

          end
        end
      end
    end
  end
end
