# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          module Refund
            # Refund Beneficiary Attributes Stub
            class BeneficiaryAttributesStub

              include GenesisRuby::Api::Mixins::Requests::Financial::Refund::BeneficiaryAttributes
              include GenesisRuby::Api::Mixins::Requests::RestrictedSetter

              public :refund_beneficiary_attributes_structure

            end
          end
        end
      end
    end
  end
end
