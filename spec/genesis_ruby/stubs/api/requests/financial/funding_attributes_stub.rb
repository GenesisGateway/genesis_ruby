module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          # Funding Attributes Stub
          class FundingAttributesStub

            include GenesisRuby::Api::Mixins::Requests::Financial::FundingAttributes

            public :funding_attributes_structure, :funding_attributes_field_validations

          end
        end
      end
    end
  end
end
