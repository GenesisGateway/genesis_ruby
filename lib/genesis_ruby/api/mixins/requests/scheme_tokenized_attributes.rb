# frozen_string_literal: true

module GenesisRuby
  module Api
    module Mixins
      module Requests
        # Scheme Tokenized Attributes mixin
        module SchemeTokenizedAttributes

          attr_reader :scheme_tokenized

          # Optional boolean that indicates whether Card Scheme Tokenization is used
          # (Visa Tokenization for Visa, Digital Secure Remote Payments (DSRP) for Mastercard)
          def scheme_tokenized=(value)
            allowed_options attribute:     __method__,
                            allowed:       [true, false],
                            value:         value,
                            allow_empty:   true,
                            error_message: 'Accepts only boolean values'
          end

          protected

          # Scheme Tokenized Attributes Structure
          def scheme_tokenized_attributes_structure
            {
              scheme_tokenized: scheme_tokenized
            }
          end

        end
      end
    end
  end
end
