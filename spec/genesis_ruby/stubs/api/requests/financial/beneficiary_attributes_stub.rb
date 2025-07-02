# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          # Beneficiary Attributes Stub
          class BeneficiaryAttributesStub

            include GenesisRuby::Api::Mixins::Requests::Financial::BeneficiaryAttributes
            include GenesisRuby::Api::Mixins::Requests::RestrictedSetter

          end
        end
      end
    end
  end
end
