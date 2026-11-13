# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module Wpf
        # Reconcile by order returns all WPF payments associated with a merchant order identifier
        # in a single, un-paginated response.
        class ReconcileByOrder < Request

          include Mixins::Requests::NonFinancial::ReconcileOrderAttributes

          protected

          # Define WPF Reconcile by Order request configuration
          def init_configuration
            init_xml_configuration
            @api_config.url = build_request_url subdomain: 'wpf', path: 'wpf/reconcile/by_order'
          end

          def init_field_validations
            required_fields.push *%i[order_id]
          end

          # WPF Reconcile by Order request structure
          def populate_structure
            @tree_structure = {
              wpf_reconcile: {
                order_id: order_id
              }
            }
          end

        end
      end
    end
  end
end
