# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module NonFinancial
          module Kyc
            # Stub class for CustomerInformationAttributes mixin
            class CustomerInformationAttributesStub

              include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
              include GenesisRuby::Api::Mixins::Requests::NonFinancial::Kyc::CustomerInformationAttributes

              public :customer_information_structure

            end
          end
        end
      end
    end
  end
end
