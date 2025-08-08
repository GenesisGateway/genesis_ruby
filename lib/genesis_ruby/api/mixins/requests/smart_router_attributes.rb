# frozen_string_literal: true

module GenesisRuby
  module Api
    module Mixins
      module Requests
        # Smart Router Attributes Mixin
        module SmartRouterAttributes

          # Use Smart Router endpoint for the current request
          def use_smart_router
            @use_smart_router ||= false
          end

          # Use Smart Router endpoint for the current request
          def use_smart_router=(value)
            unless [true, false].include? value
              raise InvalidArgumentError, 'Given invalid Use Smart Routing value! Allowed: true, false'
            end

            @use_smart_router = value
          end

          protected

          # Process the request
          def process_request_parameters
            init_api_smart_router_configuration if use_smart_router

            super
          end

        end
      end
    end
  end
end
