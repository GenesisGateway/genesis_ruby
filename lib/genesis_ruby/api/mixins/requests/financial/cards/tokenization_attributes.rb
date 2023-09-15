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
