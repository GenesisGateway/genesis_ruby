module GenesisRuby
  module Api
    module Requests
      module Financial
        module Sdd
          # Sepa Direct Debit Payment, popular in Germany.
          class Refund < Requests::Base::Reference

            protected

            # SDD Refund transaction type
            def transaction_type
              Api::Constants::Transactions::SDD_REFUND
            end

            # Reference transaction request structure
            def reference_transaction_structure
              {}
            end

          end
        end
      end
    end
  end
end
