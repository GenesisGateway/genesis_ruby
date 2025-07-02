# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          # Purpose Of Payment Attributes Stub
          class PurposeOfPaymentAttributesStub

            include GenesisRuby::Api::Mixins::Requests::Financial::PurposeOfPaymentAttributes
            include GenesisRuby::Api::Mixins::Requests::RestrictedSetter

          end
        end
      end
    end
  end
end
