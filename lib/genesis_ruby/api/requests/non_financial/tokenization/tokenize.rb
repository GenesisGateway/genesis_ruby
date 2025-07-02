# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Tokenization
          # Tokenizes cardholder data and issues a corresponding token. Merchants should take
          # care to save the plain-text token value in their system as once issued it is not possible
          # to obtain it again.
          class Tokenize < Base::Versioned

            include Api::Mixins::Requests::NonFinancial::Tokenization::CardDataAttributes
            include Api::Mixins::Requests::NonFinancial::Tokenization::TokenizationAttributes

            def initialize(configuration, builder_interface = Builder::XML)
              super configuration, builder_interface

              self.request_path = 'tokenize'
            end

            protected

            # Tokenize field validations
            def init_field_validations
              super

              required_fields.push *tokenization_required_fields, *%i[card_number]
            end

            # API Request structure
            def request_structure
              {
                tokenize_request: tokenization_attributes_structure.merge(
                  {
                    card_data: card_data_attributes_structure
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
