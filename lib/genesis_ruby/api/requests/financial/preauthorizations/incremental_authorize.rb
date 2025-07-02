# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module Financial
        module Preauthorizations
          # Incremental Authorize transaction type
          class IncrementalAuthorize < Base::Reference

            # Incremental Authorize transaction type
            def transaction_type
              Constants::Transactions::INCREMENTAL_AUTHORIZE
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
