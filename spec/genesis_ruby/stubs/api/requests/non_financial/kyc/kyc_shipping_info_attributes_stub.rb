# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module NonFinancial
          module Kyc
            # Stub class for KycShippingInfoAttributesStub mixin
            class KycShippingInfoAttributesStub

              include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
              include GenesisRuby::Api::Mixins::Requests::NonFinancial::Kyc::KycShippingInfoAttributes

              public :kyc_shipping_info_structure

            end
          end
        end
      end
    end
  end
end
