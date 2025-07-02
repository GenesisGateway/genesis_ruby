# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Tokenization
          # Exchanges the token with the tokenized cardholder data
          class Detokenize < Base::Versioned

            include Api::Mixins::Requests::NonFinancial::Tokenization::TokenAttributes
            include Api::Mixins::Requests::NonFinancial::Tokenization::TokenizationAttributes

            def initialize(configuration, builder_interface = Builder::XML)
              super configuration, builder_interface

              self.request_path = 'detokenize'
            end

            protected

            # Detokenize field validations
            def init_field_validations
              super

              required_fields.push *tokenization_required_fields, *%i[token]
            end

            # API Request structure
            def request_structure
              {
                detokenize_request: tokenization_attributes_structure.merge(
                  {
                    token: token
                  }
                )
              }
            end

          end
        end
      end
    end
  end
end
