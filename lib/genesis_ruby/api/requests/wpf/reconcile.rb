# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module Wpf
        # Reconcile can be used to retrieve data about a payment.
        # This can be useful if you want to retrieve information about a payment whose status is timeout,
        # which returned an error or has changed eg. has beed chargebacked.
        class Reconcile < Request

          attr_accessor :unique_id, :arn, :transaction_id

          protected

          # Define WPF Reconcile request configuration
          def init_configuration
            init_xml_configuration
            @api_config.url = build_request_url subdomain: 'wpf', path: 'wpf/reconcile'
          end

          # At least one of unique_id, arn or transaction_id is required
          def check_requirements
            super

            return unless %i[unique_id arn transaction_id].all? { |field| null_or_empty_field? field }

            raise ParameterError, 'One of unique_id, arn or transaction_id is required!'
          end

          # WPF Reconcile request structure
          def populate_structure
            @tree_structure = {
              wpf_reconcile: {
                unique_id:      unique_id,
                arn:            arn,
                transaction_id: transaction_id
              }
            }
          end

        end
      end
    end
  end
end
