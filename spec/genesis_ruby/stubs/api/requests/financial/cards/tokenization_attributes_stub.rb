module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          module Cards
            # Credit Card Attributes Stub
            class TokenizationAttributesStub

              include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
              include GenesisRuby::Api::Mixins::Requests::Financial::Cards::TokenizationAttributes

              public :tokenization_attributes_structure

            end
          end
        end
      end
    end
  end
end
