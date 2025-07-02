# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          # Gift Cards Attributes Stub
          class GiftCardsAttributesStub

            include GenesisRuby::Api::Mixins::Requests::Financial::GiftCardsAttributes
            include GenesisRuby::Api::Mixins::Requests::RestrictedSetter

          end
        end
      end
    end
  end
end
