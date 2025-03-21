require 'genesis_ruby/api/constants/transactions/parameters/managed_recurring/modes'
require 'genesis_ruby/api/constants/transactions/parameters/managed_recurring/intervals'
require 'genesis_ruby/api/mixins/requests/financial/cards/recurring/managed_recurring_indian_card_attributes'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module Cards
            module Recurring
              # Managed Recurring provides the option to automatically schedule recurring transactions for
              # a specific day and time. Managed Recurring is available after additional configuration.
              module ManagedRecurringAttributes

                include Recurring::ManagedRecurringIndianCardAttributes

                attr_reader :managed_recurring_time_of_day, :managed_recurring_period, :managed_recurring_max_count
                attr_accessor :managed_recurring_amount, :managed_recurring_mode, :managed_recurring_interval

                # Specifies the date of the first recurring event in the future
                # default value is date of creation + period.
                def managed_recurring_first_date
                  @managed_recurring_first_date&.strftime(
                    GenesisRuby::Api::Constants::DateTimeFormats::YYYY_MM_DD_ISO_8601
                  )
                end

                # Specifies the date of the first recurring event in the future
                # default value is date of creation + period.
                def managed_recurring_first_date=(value)
                  parse_date attribute: __method__, value: value, allow_empty: true
                end

                # Specifies the UTC hour in the day for the execution of the recurring transaction, default value 0
                def managed_recurring_time_of_day=(value)
                  parse_int attribute: __method__, value: value, allow_empty: true
                end

                # Rebill period in days(30) or months(12).
                def managed_recurring_period=(value)
                  parse_int attribute: __method__, value: value, allow_empty: true
                end

                # Maximum number of times a recurring will occur. Omit this parameter for unlimited recurring
                def managed_recurring_max_count=(value)
                  parse_int attribute: __method__, value: value, allow_empty: true
                end

                protected

                # Managed Recurring field values validation structure
                def managed_recurring_field_values
                  {
                    managed_recurring_mode:     Api::Constants::Transactions::Parameters::ManagedRecurring::Modes.all,
                    managed_recurring_interval: Api::Constants::Transactions::Parameters::ManagedRecurring::Intervals
                      .all
                  }.merge managed_recurring_indian_card_field_values
                end

                # Managed Recurring Field validation structure
                def required_recurring_managed_type_field_conditional
                  {
                    recurring_type: Hash[
                                      Api::Constants::Transactions::Parameters::Recurring::Types::MANAGED,
                                      %i[managed_recurring_mode]
                                    ]
                  }
                end

                # Managed Recurring attributes structure
                def managed_recurring_attributes_structure
                  amount = managed_recurring_amount

                  {
                    mode:        managed_recurring_mode,
                    interval:    managed_recurring_interval,
                    first_date:  managed_recurring_first_date,
                    time_of_day: managed_recurring_time_of_day,
                    period:      managed_recurring_period,
                    amount:      amount.nil? ? nil : Utils::MoneyFormat.amount_to_exponent(amount, currency),
                    max_count:   managed_recurring_max_count
                  }.merge managed_recurring_indian_card_attributes_structure
                end

              end
            end
          end
        end
      end
    end
  end
end
