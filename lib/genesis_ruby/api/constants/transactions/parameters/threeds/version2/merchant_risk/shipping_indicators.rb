# frozen_string_literal: true

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
                  SAME_AS_BILLING  = 'same_as_billing'

                  # Stored Address
                  STORED_ADDRESS   = 'stored_address'

                  # Verified Address
                  VERIFIED_ADDRESS = 'verified_address'

                  # Pick Up
                  PICK_UP          = 'pick_up'

                  # Digital Goods
                  DIGITAL_GOODS    = 'digital_goods'

                  # Travel
                  TRAVEL           = 'travel'

                  # Event Tickets
                  EVENT_TICKETS    = 'event_tickets'

                  # Other
                  OTHER            = 'other'

                end
              end
            end
          end
        end
      end
    end
  end
end
