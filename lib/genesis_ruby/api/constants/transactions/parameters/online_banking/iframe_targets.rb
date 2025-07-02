# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module OnlineBanking
            # Return URL Target attributes
            class IframeTargets

              extend Api::Mixins::Constants::Common

              # URL target for successful payment in Trustly iFrame.
              # Self
              SELF   = 'self'
              # Parent
              PARENT = 'parent'
              # Top
              TOP    = 'TOP'

            end
          end
        end
      end
    end
  end
end
