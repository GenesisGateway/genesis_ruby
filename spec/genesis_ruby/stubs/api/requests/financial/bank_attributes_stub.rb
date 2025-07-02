# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          # Bank Attributes Stub
          class BankAttributesStub

            include GenesisRuby::Api::Mixins::Requests::Financial::BankAttributes
            include GenesisRuby::Api::Mixins::Requests::RestrictedSetter

          end
        end
      end
    end
  end
end
