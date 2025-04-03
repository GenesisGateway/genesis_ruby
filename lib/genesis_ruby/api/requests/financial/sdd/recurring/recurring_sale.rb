module GenesisRuby
  module Api
    module Requests
      module Financial
        module Sdd
          module Recurring
            # Sepa Direct Debit Payment, popular in Germany.
            class RecurringSale < Requests::Base::Reference

              protected

              # SDD Recurring Sale transaction type
              def transaction_type
                Constants::Transactions::SDD_RECURRING_SALE
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
end
