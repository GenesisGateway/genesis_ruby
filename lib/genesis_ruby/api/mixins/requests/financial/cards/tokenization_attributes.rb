module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module Cards
            # Tokenization Attributes mixin
            module TokenizationAttributes

              attr_reader :remember_card
              attr_accessor :consumer_id, :token

              # Tokenizes cardholder parameters. Cannot be set together with token
              def remember_card=(value)
                allowed_options attribute:     __method__,
                                allowed:       [true, false],
                                value:         value,
                                allow_empty:   true,
                                error_message: 'Accepts only boolean values'
              end

              protected

              # Tokenization Attributes validation structure
              def required_tokenization_fields_conditional
                {
                  token:         %i[consumer_id customer_email],
                  remember_card: { true => %i[customer_email card_number] },
                  consumer_id:   %i[customer_email]
                }
              end

              # Tokenization Attributes Structure
              def tokenization_attributes_structure
                {
                  token:         token,
                  consumer_id:   consumer_id,
                  remember_card: remember_card
                }
              end

            end
          end
        end
      end
    end
  end
end
