# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module NonFinancial
          module Kyc
            # Stub class for DepositLimitsAttributesStub mixin
            class DepositLimitsAttributesStub

              include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
              include GenesisRuby::Api::Mixins::Requests::NonFinancial::Kyc::DepositLimitsAttributes

              public :deposit_limits_structure

            end
          end
        end
      end
    end
  end
end
