module GenesisRuby
  module Api
    module Requests
      module Financial
        module OnlineBankingPayments
          module InstaDebit
            # InstaDebit Payout transaction - the transaction is synchronous and
            # transaction status is set immediately after the response
            class PayOut < Idebit::PayOut

              protected

              # InstaDebit PayOut transaction type
              def transaction_type
                Constants::Transactions::INSTA_DEBIT_PAYOUT
              end

            end
          end
        end
      end
    end
  end
end
