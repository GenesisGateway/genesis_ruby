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

                attr_reader :managed_recurring_payment_type, :managed_recurring_amount_type,
                            :managed_recurring_frequency, :managed_recurring_validated

                attr_accessor :managed_recurring_registration_reference_number, :managed_recurring_max_amount

                # Payment Type of the current recurring transaction
                def managed_recurring_payment_type=(value)
                  allowed_options attribute:   __method__,
                                  allowed:     GenesisRuby::Api::Constants::Transactions::Parameters::ManagedRecurring::
                                    PaymentTypes.all,
                                  value:       value.to_s,
                                  allow_empty: true
                end

                # Amount Type of the current recurring transaction
                def managed_recurring_amount_type=(value)
                  allowed_options attribute:   __method__,
                                  allowed:     GenesisRuby::Api::Constants::Transactions::Parameters::ManagedRecurring::
                                      AmountTypes.all,
                                  value:       value.to_s,
                                  allow_empty: true
                end

                # Frequencies of the Frequency of the subsequent transactions
                def managed_recurring_frequency=(value)
                  allowed_options attribute:   __method__,
                                  allowed:     GenesisRuby::Api::Constants::Transactions::Parameters::ManagedRecurring::
                                    Frequencies.all,
                                  value:       value.to_s,
                                  allow_empty: true
                end

                # Indicates if the current transaction is valid as per the registered agreement. Values: true, false
                def managed_recurring_validated=(value)
                  allowed_options attribute:     __method__,
                                  allowed:       [true, false],
                                  value:         value,
                                  allow_empty:   true,
                                  error_message: 'Accepts only boolean values'
                end

                protected

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
