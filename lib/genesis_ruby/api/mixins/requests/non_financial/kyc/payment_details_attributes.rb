# frozen_string_literal: true

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module NonFinancial
          module Kyc
            # Payment Details Attributes mixin for KYC Non-Financial API services
            module PaymentDetailsAttributes

              attr_accessor :bin, :tail, :cvv_present, :hashed_pan, :routing, :account, :ewallet_id

              # Returns the payment details structure
              def payment_details_structure
                {
                  bin:         bin,
                  tail:        tail,
                  cvv_present: cvv_present,
                  hashed_pan:  hashed_pan,
                  routing:     routing,
                  account:     account,
                  ewallet_id:  ewallet_id
                }
              end

            end
          end
        end
      end
    end
  end
end
