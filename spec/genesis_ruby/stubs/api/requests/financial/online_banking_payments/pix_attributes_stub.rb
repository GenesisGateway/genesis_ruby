module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          module OnlineBankingPayments
            # PIX Attributes Stub
            class PixAttributesStub

              include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
              include GenesisRuby::Api::Mixins::Requests::Financial::OnlineBankingPayments::PixAttributes

            end
          end
        end
      end
    end
  end
end
