module GenesisRuby
  module Api
    module Requests
      module Financial
        module OnlineBankingPayments
          module Idebit
            # iDebit PayOut transaction class
            class PayOut < Requests::Base::Reference

              protected

              # iDebit PayOut transaction type
              def transaction_type
                Constants::Transactions::IDEBIT_PAYOUT
              end

              # iDebit PayOut parameters structure
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
