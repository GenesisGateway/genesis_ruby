require 'genesis_ruby/api/constants/transactions/parameters/managed_recurring/payment_types'
require 'genesis_ruby/api/constants/transactions/parameters/managed_recurring/amount_types'
require 'genesis_ruby/api/constants/transactions/parameters/managed_recurring/frequencies'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module Cards
            module Recurring
              # Recurring transactions with cards issued in India are subject to special rules. Prior to requesting the
              # recurring transaction, the merchant should register the recurring agreement as per the Reserve bank of
              # India (RBI) regulations.
              module ManagedRecurringIndianCardAttributes

                attr_accessor :managed_recurring_registration_reference_number, :managed_recurring_max_amount,
                              :managed_recurring_payment_type, :managed_recurring_amount_type,
                              :managed_recurring_frequency, :managed_recurring_validated

                protected

                # Managed Recurring Indian Card field values validation structure
                def managed_recurring_indian_card_field_values
                  {
                    managed_recurring_payment_type: Api::Constants::Transactions::Parameters::ManagedRecurring::
                        PaymentTypes.all,
                    managed_recurring_amount_type:  Api::Constants::Transactions::Parameters::ManagedRecurring::
                        AmountTypes.all,
                    managed_recurring_frequency:    Api::Constants::Transactions::Parameters::ManagedRecurring::
                        Frequencies.all,
                    managed_recurring_validated:    [true, false]
                  }
                end

                # Managed Recurring Indian Card attributes structure
                def managed_recurring_indian_card_attributes_structure
                  max_amount = managed_recurring_max_amount
                  amount     = max_amount.nil? ? nil : Utils::MoneyFormat.amount_to_exponent(max_amount, currency)

                  {
                    payment_type:                  managed_recurring_payment_type,
                    amount_type:                   managed_recurring_amount_type,
                    frequency:                     managed_recurring_frequency,
                    registration_reference_number: managed_recurring_registration_reference_number,
                    max_amount:                    amount,
                    validated:                     managed_recurring_validated || nil
                  }
                end

              end
            end
          end
        end
      end
    end
  end
end
