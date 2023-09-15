require 'lib/genesis_ruby/api/mixins/requests/financial/risk_attributes'

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          # Risk Param Attributes Stub
          class RiskAttributesStub

            include GenesisRuby::Api::Mixins::Requests::Financial::RiskAttributes

            public :risk_parameters_structure

          end
        end
      end
    end
  end
end
