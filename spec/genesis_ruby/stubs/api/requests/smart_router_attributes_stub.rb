# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        # Smart Router Attributes Stub
        class SmartRouterAttributesStub

          include GenesisRuby::Api::Mixins::Requests::SmartRouterAttributes

          def process_request_parameters
            init_api_smart_router_configuration if use_smart_router
          end

        end
      end
    end
  end
end
