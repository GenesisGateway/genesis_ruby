module GenesisSpec
  module Stubs
    module Api
      module Requests
        module NonFinancial
          module Tokenization
            # Token Attributes Stub
            class TokenAttributesStub

              include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
              include GenesisRuby::Api::Mixins::Requests::NonFinancial::Tokenization::TokenAttributes

            end
          end
        end
      end
    end
  end
end
