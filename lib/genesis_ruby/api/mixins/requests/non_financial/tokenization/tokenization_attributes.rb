# frozen_string_literal: true

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module NonFinancial
          module Tokenization
            # Common Tokenization API Attributes mixin
            module TokenizationAttributes

              attr_accessor :token_type
              attr_reader   :consumer_id, :email

              # Consumer unique reference
              def consumer_id=(value)
                limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 10
              end

              # Consumer e-mail address
              def email=(value)
                parse_email attribute: __method__, value: value, allow_empty: true
              end

              protected

              def tokenization_required_fields
                %i[consumer_id email token_type]
              end

              # Tokenization Attributes Structure
              def tokenization_attributes_structure
                {
                  consumer_id: consumer_id,
                  email:       email,
                  token_type:  token_type
                }
              end

            end
          end
        end
      end
    end
  end
end
