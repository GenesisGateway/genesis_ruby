module GenesisSpec
  module Stubs
    module Api
      module Requests
        module NonFinancial
          module Tokenization
            # Tokenization Attributes Stub
            class TokenizationAttributesStub

              include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
              include GenesisRuby::Api::Mixins::Requests::NonFinancial::Tokenization::TokenizationAttributes

              # Change method scope to public
              public :tokenization_attributes_structure

            end
          end
        end
      end
    end
  end
end
