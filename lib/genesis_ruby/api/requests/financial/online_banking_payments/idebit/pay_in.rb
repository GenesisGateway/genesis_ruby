module GenesisRuby
  module Api
    module Requests
      module Financial
        module OnlineBankingPayments
          module Idebit
            # iDebit PayIn transaction class
            class PayIn < Requests::Base::Financial

              include Api::Mixins::Requests::AddressInfoAttributes
              include Api::Mixins::Requests::BirthDateAttributes
              include Api::Mixins::Requests::Financial::PaymentAttributes

              attr_reader :customer_account_id

              # Customer account id parameter validation
              def customer_account_id=(value)
                limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 20
              end

              protected

              # iDebit PayIn transaction type
              def transaction_type
                Api::Constants::Transactions::IDEBIT_PAYIN
              end

              # iDebit PayIn field validations
              def init_field_validations
                required_fields.push *%i[transaction_id customer_account_id amount currency billing_country]

                field_values.merge! billing_country: 'CA'
              end

              # iDebit PayIn parameters structure
              def payment_transaction_structure
                payment_attributes_structure.merge(
                  {
                    customer_email:      customer_email,
                    customer_phone:      customer_phone,
                    customer_account_id: customer_account_id,
                    birth_date:          birth_date,
                    billing_address:     billing_address_parameters_structure,
                    shipping_address:    shipping_address_parameters_structure
                  }
                )
              end

            end
          end
        end
      end
    end
  end
end
