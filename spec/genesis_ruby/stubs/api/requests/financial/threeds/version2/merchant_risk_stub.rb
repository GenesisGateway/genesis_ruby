module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          module Threeds
            module Version2
              class MerchantRiskStub

                include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
                include GenesisRuby::Api::Mixins::Requests::Financial::Threeds::Version2::MerchantRisk

                public :merchant_risk_attributes

              end
            end
          end
        end
      end
    end
  end
end
