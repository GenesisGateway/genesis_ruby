# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module NonFinancial
            # Allowed values for the required scope filter of the reporting date range requests
            # (Processed Transactions, Chargebacks, Retrieval Requests, Rapid Dispute Resolutions)
            class Scopes

              extend Mixins::Constants::Common

              CARD_PRESENT     = 'card_present'
              CARD_NOT_PRESENT = 'card_not_present'
              EXTERNAL         = 'external'

            end
          end
        end
      end
    end
  end
end
