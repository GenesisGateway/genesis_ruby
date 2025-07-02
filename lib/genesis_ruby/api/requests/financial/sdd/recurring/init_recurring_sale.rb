# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module Financial
        module Sdd
          module Recurring
            # Sepa Direct Debit initial recurring
            class InitRecurringSale < Api::Requests::Financial::Sdd::Sale

              protected

              # SDD Sale transaction type
              def transaction_type
                Api::Constants::Transactions::SDD_INIT_RECURRING_SALE
              end

            end
          end
        end
      end
    end
  end
end
