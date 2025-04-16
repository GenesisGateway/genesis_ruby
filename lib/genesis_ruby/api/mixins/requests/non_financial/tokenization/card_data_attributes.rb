module GenesisRuby
  module Api
    module Mixins
      module Requests
        module NonFinancial
          module Tokenization
            # Card Data Attributes mixin
            module CardDataAttributes

              attr_accessor :card_holder
              attr_reader   :card_number, :expiration_month, :expiration_year

              # Complete credit/debit card number of customer
              def card_number=(value)
                limited_string attribute: __method__, value: value.to_s, min: 13, max: 19
              end

              # Expiration month as printed on credit card
              def expiration_month=(value)
                error_message = format(
                  'Invalid value "%{value}" given for %{attribute}, should be in MM format',
                  value: value,
                  attribute: __method__
                )

                raise GenesisRuby::ParameterError, error_message unless value.nil? || value =~ /^(0[1-9]|1[0-2])$/

                @expiration_month = value
              end

              # Expiration year as printed on credit card
              def expiration_year=(value)
                error_message = format(
                  'Invalid value "%{value}" given for %{attribute}, should be in YYYY format',
                  value: value,
                  attribute: __method__
                )

                raise GenesisRuby::ParameterError, error_message unless value.nil? || value =~ /^(20)\d{2}$/

                @expiration_year = value
              end

              protected

              # Card Data Attributes Structure
              def card_data_attributes_structure
                {
                  card_number:      card_number,
                  card_holder:      card_holder,
                  expiration_month: expiration_month,
                  expiration_year:  expiration_year
                }
              end

            end
          end
        end
      end
    end
  end
end
