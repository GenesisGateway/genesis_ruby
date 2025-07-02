# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Tokenization
          # Validates if a token is active, owned by a merchant, etc.
          class ValidateToken < Base::Versioned

            include Api::Mixins::Requests::NonFinancial::Tokenization::TokenAttributes
            include Api::Mixins::Requests::NonFinancial::Tokenization::TokenizationAttributes

            def initialize(configuration, builder_interface = Builder::XML)
              super configuration, builder_interface

              self.request_path = 'validate_token'
            end

            protected

            # Validate Token field validations
            def init_field_validations
              super

              required_fields.push *tokenization_required_fields, *%i[token]
            end

            # API Request structure
            def request_structure
              {
                validate_token_request: tokenization_attributes_structure.merge(
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
