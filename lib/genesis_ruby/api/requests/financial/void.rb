module GenesisRuby
  module Api
    module Requests
      module Financial
        # Void or undo payment transaction request
        class Void < Base::Financial

          include Mixins::Requests::Financial::ReferenceAttributes

          protected

          # Void transaction type
          def transaction_type
            Api::Constants::Transactions::VOID
          end

          # Void transaction request structure
          def payment_transaction_structure
            {
              reference_id: reference_id
            }
          end

        end
      end
    end
  end
end
