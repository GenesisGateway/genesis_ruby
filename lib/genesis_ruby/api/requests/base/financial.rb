# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module Base
        # Base class used by all Financial transaction requests
        class Financial < Request

          include Mixins::Requests::Financial::BaseAttributes
          include Mixins::Requests::Financial::PaymentAttributes
          include Mixins::Requests::SmartRouterAttributes

          protected

          # Returns the Request transaction type
          def transaction_type
            raise NotImplementedError, 'Transaction Type method must be implemented'
          end

          # Return additional request attributes
          def payment_transaction_structure
            raise NotImplementedError, 'Payment Transaction Structure method must be implemented'
          end

          # Request Configuration
          def init_configuration
            super
            init_xml_configuration
            init_api_gateway_configuration
            init_api_smart_router_configuration if @configuration.force_smart_routing
          end

          # Populate the request structure
          def populate_structure
            self.tree_structure = {
              payment_transaction: {
                transaction_type: transaction_type,
                transaction_id:   transaction_id,
                usage:            usage,
                remote_ip:        remote_ip
              }.merge(payment_attributes_structure, payment_transaction_structure)
            }
          end

          # Initialize Smart Router endpoint
          def init_api_smart_router_configuration
            api_config.url = build_request_url({ subdomain: 'smart_router', path: 'transactions' })
          end

          # Initialize Financial class validations
          def init_field_validations
            super

            field_values.merge! currency: Api::Constants::Currencies::Iso4217.all.map(&:upcase)
          end

        end
      end
    end
  end
end
