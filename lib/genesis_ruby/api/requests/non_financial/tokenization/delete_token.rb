module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Tokenization
          # Deletes a token
          class DeleteToken < Base::Versioned

            include Api::Mixins::Requests::NonFinancial::Tokenization::TokenAttributes
            include Api::Mixins::Requests::NonFinancial::Tokenization::TokenizationAttributes

            def initialize(configuration, builder_interface = Builder::XML)
              super configuration, builder_interface

              self.request_path = 'delete_token'
            end

            protected

            # Delete Token field validations
            def init_field_validations
              super

              required_fields.push *tokenization_required_fields, *%i[token]
            end

            # API Request structure
            def request_structure
              {
                delete_token_request: tokenization_attributes_structure.merge(
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
