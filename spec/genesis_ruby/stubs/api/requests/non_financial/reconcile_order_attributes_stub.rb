# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module NonFinancial
          # Reconcile Order Attributes Stub
          class ReconcileOrderAttributesStub

            include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
            include GenesisRuby::Api::Mixins::Requests::NonFinancial::ReconcileOrderAttributes

          end
        end
      end
    end
  end
end
