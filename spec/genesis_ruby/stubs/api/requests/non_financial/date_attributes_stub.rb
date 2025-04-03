module GenesisSpec
  module Stubs
    module Api
      module Requests
        module NonFinancial
          # Date Attributes Stub
          class DateAttributesStub

            include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
            include GenesisRuby::Api::Mixins::Requests::NonFinancial::DateAttributes

          end
        end
      end
    end
  end
end
