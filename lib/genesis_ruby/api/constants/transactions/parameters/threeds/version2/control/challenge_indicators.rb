# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module Threeds
            module Version2
              module Control
                # Threeds Version2 Control Challenge Indicators
                class ChallengeIndicators

                  extend Mixins::Constants::Common

                  # Don't have any preferences related to the Challenge flow (default)
                  NO_PREFERENCE          = 'no_preference'

                  # I prefer that a Challenge flow does not take place
                  NO_CHALLENGE_REQUESTED = 'no_challenge_requested'

                  # A request for the Challenge flow to take place
                  PREFERENCE             = 'preference'

                  # A Challenge flow must take place to fulfill a mandate
                  MANDATE                = 'mandate'

                end
              end
            end
          end
        end
      end
    end
  end
end
