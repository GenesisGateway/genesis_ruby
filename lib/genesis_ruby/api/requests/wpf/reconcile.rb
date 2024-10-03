module GenesisRuby
  module Api
    module Requests
      module Wpf
        # Reconcile can be used to retrieve data about a payment.
        # This can be useful if you want to retrieve information about a payment whose status is timeout,
        # which returned an error or has changed eg. has beed chargebacked.
        class Reconcile < Request

          attr_accessor :unique_id

          protected

          # Define WPF Reconcile request configuration
          def init_configuration
            init_xml_configuration
            @api_config.url = build_request_url subdomain: 'wpf', path: 'wpf/reconcile'
          end

          def init_field_validations
            required_fields.push *%i[unique_id]
          end

          # WPF Reconcile request structure
          def populate_structure
            @tree_structure = {
              wpf_reconcile: {
                unique_id: unique_id
              }
            }
          end

        end
      end
    end
  end
end
