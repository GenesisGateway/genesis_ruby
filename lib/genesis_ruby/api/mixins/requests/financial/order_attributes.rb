# frozen_string_literal: true

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          # Merchant Order attributes. Groups multiple transactions under a single business order.
          # Transaction order IDs must be enabled for the merchant in the Genesis admin.
          module OrderAttributes

            # Maximum length of the merchant order identifier
            ORDER_ID_MAX_LENGTH = 255

            attr_reader :order_id

            # Merchant order identifier, any string up to 255 characters
            def order_id=(value)
              limited_string attribute: __method__,
                             value:     value.to_s.empty? ? nil : value.to_s,
                             max:       ORDER_ID_MAX_LENGTH
            end

            protected

            # Order request structure
            def order_attributes_structure
              { order_id: order_id }
            end

          end
        end
      end
    end
  end
end
