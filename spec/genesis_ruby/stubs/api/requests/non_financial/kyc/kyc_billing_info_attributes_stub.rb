# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module NonFinancial
          module Kyc
            # Stub class for KycBillingInfoAttributesStub mixin
            class KycBillingInfoAttributesStub

              include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
              include GenesisRuby::Api::Mixins::Requests::NonFinancial::Kyc::KycBillingInfoAttributes

              public :kyc_billing_info_structure

            end
          end
        end
      end
    end
  end
end
