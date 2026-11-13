# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Reconcile
          # Reconcile by order returns all payment transactions associated with a merchant order identifier
          # in a single, un-paginated response.
          class Order < Api::Requests::Base::NonFinancial::Reconcile::Base

            include Mixins::Requests::NonFinancial::ReconcileOrderAttributes

            protected

            # The Reconcile API path
            def request_path
              'reconcile/by_order'
            end

            # Required fields
            def init_field_validations
              required_fields.push *%i[order_id]
            end

            # API Request structure
            def populate_structure
              @tree_structure = {
                reconcile: {
                  order_id: order_id
                }
              }
            end

          end
        end
      end
    end
  end
end
