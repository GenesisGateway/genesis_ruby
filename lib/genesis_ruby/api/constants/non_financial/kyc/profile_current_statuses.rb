# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module NonFinancial
        module Kyc
          # Profile current statuses
          class ProfileCurrentStatuses

            extend Mixins::Constants::Common

            # Undefined
            UNDEFINED = 0
            # Review
            REVIEW    = 1
            # Denied
            DENIED    = 2
            # Approved
            APPROVED  = 3

          end
        end
      end
    end
  end
end
