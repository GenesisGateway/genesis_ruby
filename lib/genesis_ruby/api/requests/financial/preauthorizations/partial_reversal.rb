# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module Financial
        module Preauthorizations
          # Partial Reversal transaction type
          class PartialReversal < Base::Reference

            # Partial Reversal transaction type
            def transaction_type
              Constants::Transactions::PARTIAL_REVERSAL
            end

            # Returns the transaction structure
            def reference_transaction_structure
              {}
            end

          end
        end
      end
    end
  end
end
