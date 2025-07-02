# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          module OnlineBankingPayments
            # Payer Attributes Stub
            class PayerAttributesStub

              include GenesisRuby::Api::Mixins::Requests::Financial::OnlineBankingPayments::PayerAttributes
              include GenesisRuby::Api::Mixins::Requests::RestrictedSetter

            end
          end
        end
      end
    end
  end
end
