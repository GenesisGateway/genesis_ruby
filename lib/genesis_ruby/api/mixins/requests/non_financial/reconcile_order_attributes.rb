# frozen_string_literal: true

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module NonFinancial
          # Reconcile Order Attributes mixin
          module ReconcileOrderAttributes

            # Maximum allowed length of the order_id value
            ORDER_ID_MAX_LENGTH = 255

            attr_reader :order_id

            # The merchant order identifier to filter by
            def order_id=(value)
              if value.to_s.empty?
                assign_instance_variable __method__, nil
              else
                limited_string attribute: __method__, value: value, max: ORDER_ID_MAX_LENGTH
              end
            end

          end
        end
      end
    end
  end
end
