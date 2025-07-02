# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module CustomerAddress
          # ShippingInfoAttributes Stub
          class ShippingInfoAttributesStub

            include GenesisRuby::Api::Mixins::Requests::CustomerAddress::ShippingInfoAttributes

            # Change method scope to public
            public :shipping_address_parameters_structure

          end
        end
      end
    end
  end
end
