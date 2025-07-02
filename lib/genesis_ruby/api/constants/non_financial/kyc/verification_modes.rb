# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module NonFinancial
        module Kyc
          # The types of proof that can be used for verification
          class VerificationModes

            extend Mixins::Constants::Common

            # Any verification mode
            ANY        = 'any'

            # Image only verification mode
            IMAGE_ONLY = 'image_only'

            # Video only verification mode
            VIDEO_ONLY = 'video_only'

          end
        end
      end
    end
  end
end
