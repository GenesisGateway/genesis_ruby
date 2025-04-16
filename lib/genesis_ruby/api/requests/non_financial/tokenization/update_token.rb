module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Tokenization
          # Updates the tokenized data corresponding to an existing valid token
          class UpdateToken < Base::Versioned

            include Api::Mixins::Requests::NonFinancial::Tokenization::CardDataAttributes
            include Api::Mixins::Requests::NonFinancial::Tokenization::TokenAttributes
            include Api::Mixins::Requests::NonFinancial::Tokenization::TokenizationAttributes

            def initialize(configuration, builder_interface = Builder::XML)
              super configuration, builder_interface

              self.request_path = 'update_token'
            end

            protected

            # Update Token field validations
            def init_field_validations
              super

              required_fields.push *tokenization_required_fields, *%i[card_number token]
            end

            # API Request structure
            def request_structure
              {
                update_token_request: tokenization_attributes_structure.merge(
                  {
                    token:     token,
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
