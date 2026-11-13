# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module Base
        module NonFinancial
          module Reconcile
            # Base Request class for the S2S Reconcile API requests.
            # Builds the terminal based endpoint, or the Smart Router one when Smart Routing is used.
            class Base < Api::Request

              include Mixins::Requests::SmartRouterAttributes

              protected

              # The Reconcile API path, defined by the concrete request
              def request_path
                'reconcile'
              end

              # Set Gateway API configuration
              def init_configuration
                init_xml_configuration
                init_api_gateway_configuration request_path: request_path
                init_api_smart_router_configuration if @configuration.force_smart_routing
              end

              # Initialize Smart Router endpoint
              def init_api_smart_router_configuration
                api_config.url = build_request_url({ subdomain: 'smart_router', path: request_path })
              end

              # Smart Routing is requested for the current request or forced by the configuration
              def smart_router_active?
                use_smart_router || @configuration.force_smart_routing
              end

            end
          end
        end
      end
    end
  end
end
