module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Installments
          # Fetch the applicable installments for a given amount, currency and card brand.
          class Fetch < Base::Versioned

            attr_reader :amount, :card_number
            attr_accessor :currency

            # Installments Fetch initialization
            def initialize(configuration, _builder_interface = nil)
              super configuration

              self.request_path = 'installments'
            end

            # Amount of transaction in minor currency unit
            def amount=(value)
              raise InvalidArgumentError, 'Invalid Amount given, only integer value allowed!' unless value.is_a? Integer

              @amount = value
            end

            # Complete cc number of customer
            def card_number=(value)
              value = value.to_s

              raise InvalidArgumentError, 'Invalid Credit Card number given!' unless value =~ /\A[0-9]{13,19}\Z/

              @card_number = value
            end

            protected

            # Fetch request field validations
            def init_field_validations
              super

              required_fields.push *%i[amount currency card_number]
              field_values.merge! currency: Constants::Currencies::Iso4217.all.map(&:upcase)
            end

            # Installments Fetch request structure
            def request_structure
              {
                amount:      amount,
                currency:    currency,
                card_number: card_number
              }
            end

          end
        end
      end
    end
  end
end
