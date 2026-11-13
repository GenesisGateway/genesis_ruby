# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          # Marketplace Data foreign retailer indicator allowed values
          #
          # The value is uppercase. Always call `.valid?` with `strict: true`:
          # the non-strict mode downcases the input and never matches `FOREIGN_RETAILER`.
          class ForeignRetailerIndicators

            extend Mixins::Constants::Common

            # Foreign retailer transaction
            FOREIGN_RETAILER = 'F'

          end
        end
      end
    end
  end
end
