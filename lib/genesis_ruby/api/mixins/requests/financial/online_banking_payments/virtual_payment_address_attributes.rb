module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module OnlineBankingPayments
            # Virtual Payment Address Attributes
            module VirtualPaymentAddressAttributes

              attr_reader :virtual_payment_address

              # Virtual Payment Address (VPA) of the customer, format: someone@bank
              def virtual_payment_address=(value)
                @virtual_payment_address = value.to_s

                return if value.to_s.empty? || value =~ /\A.+@.+\Z/

                raise InvalidArgumentError, 'Virtual Payment Address has invalid format. Correct format: someone@bank'
              end

            end
          end
        end
      end
    end
  end
end
