module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          # Gift Cards Attributes mixin
          module GiftCardsAttributes

            attr_reader :card_number, :cvv

            # Gift card number
            def card_number=(value)
              limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, min: 19, max: 21
            end

            # Verification code of the gift card
            def cvv=(value)
              limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, min: 5, max: 8
            end

          end
        end
      end
    end
  end
end
