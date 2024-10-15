module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module Wallets
            module PayPal
              # Pay Pal allowed payment types
              class PaymentTypes

                extend Api::Mixins::Constants::Common

                # Creates an order that should be captured later.
                AUTHORIZE = 'authorize'.freeze

                # Captures the created order immediately after the buyer confirms the payment.
                SALE      = 'sale'.freeze

                # Creates an Express Checkout PayPal payment. Express Checkout eliminates one of the
                # major causes of checkout abandonment by giving buyers all the transaction details at
                # once, including order details, shipping options, insurance choices, and tax totals.
                EXPRESS   = 'express'.freeze

              end
            end
          end
        end
      end
    end
  end
end
