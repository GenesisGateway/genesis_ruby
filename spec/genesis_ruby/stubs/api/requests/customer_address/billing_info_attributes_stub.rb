# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module CustomerAddress
          # BillingInfoAttributes Stub
          class BillingInfoAttributesStub

            include GenesisRuby::Api::Mixins::Requests::CustomerAddress::BillingInfoAttributes

            # Change method scope to public
            public :billing_address_parameters_structure

          end
        end
      end
    end
  end
end
