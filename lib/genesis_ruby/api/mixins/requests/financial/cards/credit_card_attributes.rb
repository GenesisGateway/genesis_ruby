module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module Cards
            # Credit Card Attributes
            module CreditCardAttributes

              attr_accessor :card_holder, :card_number, :cvv, :expiration_month, :expiration_year

              protected

              # Credit Card Attributes Structure
              def credit_card_attributes_structure
                {
                  card_holder:      card_holder,
                  card_number:      card_number,
                  expiration_month: expiration_month,
                  expiration_year:  expiration_year,
                  cvv:              cvv
                }
              end

            end
          end
        end
      end
    end
  end
end
