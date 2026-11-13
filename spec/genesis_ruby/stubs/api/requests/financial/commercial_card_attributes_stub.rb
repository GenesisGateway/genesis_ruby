# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          # Commercial Card Attributes Stub
          class CommercialCardAttributesStub < GenesisRuby::Api::Request

            include GenesisRuby::Api::Mixins::Requests::Financial::CommercialCardAttributes

            attr_accessor :currency

            # Change method scope to public
            public :commercial_card_attributes_structure, :validate_commercial_card_attributes

          end
        end
      end
    end
  end
end
