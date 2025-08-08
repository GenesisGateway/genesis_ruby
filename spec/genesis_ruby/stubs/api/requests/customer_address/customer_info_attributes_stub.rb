# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module CustomerAddress
          # CustomerInfoAttributes Stub
          class CustomerInfoAttributesStub

            include GenesisRuby::Api::Mixins::Requests::CustomerAddress::CustomerInfoAttributes
            include GenesisRuby::Api::Mixins::Requests::RestrictedSetter

          end
        end
      end
    end
  end
end
