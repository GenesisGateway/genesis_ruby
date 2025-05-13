module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module CustomerIdentification
            # Specifies the type of the document ID.
            class CustomerIdentificationSubtype

              extend Api::Mixins::Constants::Common

              # Document ID type - business
              BUSINESS   = 'business'.freeze

              # Document ID type - individual
              INDIVIDUAL = 'individual'.freeze

            end
          end
        end
      end
    end
  end
end
