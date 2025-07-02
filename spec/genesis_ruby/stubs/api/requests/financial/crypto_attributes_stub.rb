# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          class CryptoAttributesStub

            include GenesisRuby::Api::Mixins::Requests::Financial::CryptoAttributes
            include GenesisRuby::Api::Mixins::Requests::RestrictedSetter

          end
        end
      end
    end
  end
end
