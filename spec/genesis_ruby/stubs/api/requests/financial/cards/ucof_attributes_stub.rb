module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          module Cards
            # UCOF attributes stub
            class UcofAttributesStub

              include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
              include GenesisRuby::Api::Mixins::Requests::Financial::Cards::UcofAttributes

            end
          end
        end
      end
    end
  end
end
