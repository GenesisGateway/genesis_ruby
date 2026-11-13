# frozen_string_literal: true

require 'bigdecimal'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          # Commercial Card Data attributes (Mastercard Large Ticket Interchange)
          module CommercialCardAttributes

            # Item type sent with every commercial card item
            COMMERCIAL_CARD_ITEM_TYPE = 'commercial_card'
            private_constant :COMMERCIAL_CARD_ITEM_TYPE

            # Commercial card attribute names, used for the readers and the data supplied / absent check
            COMMERCIAL_CARD_FIELDS = %i[
              commercial_card_name commercial_card_reference commercial_card_customer_code
              commercial_card_quantity commercial_card_tax_rate commercial_card_unit_price
              commercial_card_total_tax_amount commercial_card_total_discount_amount
            ].freeze
            private_constant :COMMERCIAL_CARD_FIELDS

            attr_reader(*COMMERCIAL_CARD_FIELDS)

            # Item name writer (max 35 chars)
            def commercial_card_name=(value)
              limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 35
            end

            # Item reference writer (max 15 chars)
            def commercial_card_reference=(value)
              limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 15
            end

            # Merchant customer code writer (max 17 chars)
            def commercial_card_customer_code=(value)
              limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 17
            end

            # Quantity writer: Integer or digit String, 1..9_999_999_999, stored as Integer
            def commercial_card_quantity=(value)
              quantity = value.to_s.match?(/\A\d+\z/) ? value.to_s.to_i : nil

              unless value.to_s.empty? || (1..9_999_999_999).cover?(quantity)
                raise InvalidArgumentError, 'commercial_card_quantity must be an integer in range 1 to 9999999999'
              end

              @commercial_card_quantity = quantity
            end

            # Tax rate writer: Percent_Input, stored as its textual form
            def commercial_card_tax_rate=(value)
              text = commercial_card_text(value)

              unless text.nil? || (text.match?(/\A\d{1,2}(\.\d{1,2})?\z/) && BigDecimal(text).positive?)
                raise InvalidArgumentError,
                      'commercial_card_tax_rate must be a percent in range 0.01 to 99.99 with up to two decimal places'
              end

              @commercial_card_tax_rate = text
            end

            # Unit price writer: textual form in major units; validated by transform_amount, like `amount`
            def commercial_card_unit_price=(value)
              @commercial_card_unit_price = commercial_card_text(value)
            end

            # Total tax amount writer: textual form in major units; validated by transform_amount
            def commercial_card_total_tax_amount=(value)
              @commercial_card_total_tax_amount = commercial_card_text(value)
            end

            # Total discount amount writer: textual form in major units; validated by transform_amount
            def commercial_card_total_discount_amount=(value)
              @commercial_card_total_discount_amount = commercial_card_text(value)
            end

            protected

            # Commercial card item structure, children in the documented order. Returns {} while no field is set.
            def commercial_card_attributes_structure # rubocop:disable Metrics/MethodLength
              return {} unless commercial_card_data_supplied?

              {
                item: {
                  item_type:             COMMERCIAL_CARD_ITEM_TYPE,
                  name:                  commercial_card_name,
                  reference:             commercial_card_reference,
                  quantity:              commercial_card_quantity,
                  unit_price:            transform_amount(commercial_card_unit_price, currency),
                  tax_rate:              commercial_card_tax_rate_value,
                  total_tax_amount:      transform_amount(commercial_card_total_tax_amount, currency),
                  total_discount_amount: transform_amount(commercial_card_total_discount_amount, currency),
                  merchant_data:         { customer_code: commercial_card_customer_code }
                }
              }
            end

            # Contextual validation, called from check_requirements after super.
            # Raises for the first missing required field, in the documented order, then for name or reference.
            def validate_commercial_card_attributes
              return unless commercial_card_data_supplied?

              validate_required_fields %i[
                commercial_card_quantity commercial_card_unit_price commercial_card_tax_rate
                commercial_card_total_tax_amount commercial_card_total_discount_amount
              ]
              return unless commercial_card_name.nil? && commercial_card_reference.nil?

              raise ParameterError,
                    'commercial_card_name or commercial_card_reference is required when commercial card data ' \
                    'is supplied'
            end

            private

            # Textual form of a value, nil for nil or ''
            def commercial_card_text(value)
              return nil if value.to_s.empty?

              value.is_a?(BigDecimal) ? value.to_s('F') : value.to_s
            end

            # Whether any commercial card field holds a value. Every writer stores nil for '', so nil means unset.
            def commercial_card_data_supplied?
              COMMERCIAL_CARD_FIELDS.any? { |field| !public_send(field).nil? }
            end

            # Tax rate rendered value: percent * 100 as Integer, independent of currency
            def commercial_card_tax_rate_value
              return nil if commercial_card_tax_rate.nil?

              (BigDecimal(commercial_card_tax_rate) * 100).to_i
            end

          end
        end
      end
    end
  end
end
