module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module Threeds
            module Version2
              module MerchantRisk
                # Threeds Version2 Merchant Risk Shipping Indicators
                class ShippingIndicators

                  extend Mixins::Constants::Common

                  # Sale as Billing
                  SAME_AS_BILLING  = 'same_as_billing'.freeze

                  # Stored Address
                  STORED_ADDRESS   = 'stored_address'.freeze

                  # Verified Address
                  VERIFIED_ADDRESS = 'verified_address'.freeze

                  # Pick Up
                  PICK_UP          = 'pick_up'.freeze

                  # Digital Goods
                  DIGITAL_GOODS    = 'digital_goods'.freeze

                  # Travel
                  TRAVEL           = 'travel'.freeze

                  # Event Tickets
                  EVENT_TICKETS    = 'event_tickets'.freeze

                  # Other
                  OTHER            = 'other'.freeze

                end
              end
            end
          end
        end
      end
    end
  end
end
