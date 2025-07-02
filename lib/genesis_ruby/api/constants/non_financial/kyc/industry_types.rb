# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module NonFinancial
        module Kyc
          # IndustryTypes
          class IndustryTypes

            extend Mixins::Constants::Common

            # Definition of the industry type the transaction was performed on
            FINANCE       = 1
            GAMBLING      = 2
            CRYPTO        = 3
            TRAVEL        = 4
            RETAIL        = 5
            RISK_VENDOR   = 6
            ADULT         = 7
            REMITTANCE    = 8
            OTHER         = 9

          end
        end
      end
    end
  end
end
