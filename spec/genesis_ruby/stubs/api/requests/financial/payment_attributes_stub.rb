# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          # Payment Attributes Stub
          class PaymentAttributesStub < GenesisRuby::Api::Request

            include GenesisRuby::Api::Mixins::Requests::Financial::PaymentAttributes

            # Change method scope to public
            public :payment_attributes_structure

          end
        end
      end
    end
  end
end
