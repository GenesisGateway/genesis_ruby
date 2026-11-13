# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module NonFinancial
          # Date Time From To Attributes Stub
          class DateTimeFromToAttributesStub

            include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
            include GenesisRuby::Api::Mixins::Requests::NonFinancial::DateTimeFromToAttributes

          end
        end
      end
    end
  end
end
