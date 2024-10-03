module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module Mobile
            module GooglePay
              # Payment Subtype allowed values
              class PaymentSubtypes

                extend Mixins::Constants::Common

                # Google Pay authorize payment subtype
                AUTHORIZE           = 'authorize'.freeze

                # Google Pay init_recurring_sale payment subtype
                INIT_RECURRING_SALE = 'init_recurring_sale'.freeze

                # Google Pay sale payment subtype
                SALE                = 'sale'.freeze

              end
            end
          end
        end
      end
    end
  end
end
