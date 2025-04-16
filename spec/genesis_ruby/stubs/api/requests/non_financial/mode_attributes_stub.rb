module GenesisSpec
  module Stubs
    module Api
      module Requests
        module NonFinancial
          # Mode Attributes Stub
          class ModeAttributesStub

            include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
            include GenesisRuby::Api::Mixins::Requests::NonFinancial::ModeAttributes

          end
        end
      end
    end
  end
end
