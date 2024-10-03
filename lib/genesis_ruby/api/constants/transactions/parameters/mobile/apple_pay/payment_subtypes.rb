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
                AUTHORIZE           = 'authorize'.freeze

                # Apple Pay init_recurring_sale payment subtype
                INIT_RECURRING_SALE = 'init_recurring_sale'.freeze

                # Apple Pay sale payment subtype
                SALE                = 'sale'.freeze

              end
            end
          end
        end
      end
    end
  end
end
