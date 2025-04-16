module GenesisSpec
  module Stubs
    module Api
      module Requests
        module NonFinancial
          module Tokenization
            # Card Data Attributes Stub
            class CardDataAttributesStub

              include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
              include GenesisRuby::Api::Mixins::Requests::NonFinancial::Tokenization::CardDataAttributes

              # Change method scope to public
              public :card_data_attributes_structure

            end
          end
        end
      end
    end
  end
end
