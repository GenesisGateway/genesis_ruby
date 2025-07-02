# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module NonFinancial
        module Kyc
          # VerificationStatuses class for KYC Non-Financial API services
          class VerificationStatuses

            extend Mixins::Constants::Common

            # In Progress
            IN_PROGRESS          = '1'
            # Failed
            FAILED               = '2'
            # Verification Failed
            VERIFICATION_FAILED  = '3'
            # Verification Success
            VERIFICATION_SUCCESS = '4'
            # Abandon
            ABANDON              = '5'

          end
        end
      end
    end
  end
end
