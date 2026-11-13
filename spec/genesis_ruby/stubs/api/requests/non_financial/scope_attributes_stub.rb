# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module NonFinancial
          # Scope Attributes Stub
          class ScopeAttributesStub

            include GenesisRuby::Api::Mixins::Requests::RestrictedSetter
            include GenesisRuby::Api::Mixins::Requests::NonFinancial::ScopeAttributes

          end
        end
      end
    end
  end
end
