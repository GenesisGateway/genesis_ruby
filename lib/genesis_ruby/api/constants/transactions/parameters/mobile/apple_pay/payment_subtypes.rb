# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module Mobile
            module ApplePay
              # Apple Pay Payment Subtypes allowed values
              class PaymentSubtypes

                extend Mixins::Constants::Common

                # Apple Pay authorize payment subtype
                AUTHORIZE           = 'authorize'

                # Apple Pay init_recurring_sale payment subtype
                INIT_RECURRING_SALE = 'init_recurring_sale'

                # Apple Pay sale payment subtype
                SALE                = 'sale'

              end
            end
          end
        end
      end
    end
  end
end
