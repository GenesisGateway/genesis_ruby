# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Tokenization
          # Get cryptogram on behalf of a token that will be used for the authorization
          class Cryptogram < Base::Versioned

            include Api::Mixins::Requests::NonFinancial::Tokenization::TokenAttributes
            include Api::Mixins::Requests::NonFinancial::Tokenization::TokenizationAttributes

            attr_accessor :transaction_reference

            def initialize(configuration, builder_interface = Builder::XML)
              super configuration, builder_interface

              self.request_path = 'cryptogram'
            end

            protected

            # Cryptogram field validations
            def init_field_validations
              super

              required_fields.push *tokenization_required_fields, *%i[token transaction_reference]
            end

            # API Request structure
            def request_structure
              {
                cryptogram_request: tokenization_attributes_structure.merge(
                  {
                    token:                 token,
                    transaction_reference: transaction_reference
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
