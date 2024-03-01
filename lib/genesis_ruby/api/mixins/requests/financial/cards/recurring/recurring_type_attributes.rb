require 'genesis_ruby/api/constants/transactions/parameters/recurring/types'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module Cards
            module Recurring
              # Recurring Type Attributes
              module RecurringTypeAttributes

                attr_reader :recurring_type

                # Specifies the recurring type of transaction
                def recurring_type=(value)
                  allowed_options attribute:   __method__,
                                  allowed:     GenesisRuby::Api::Constants::Transactions::Parameters::Recurring::
                                      Types.all,
                                  value:       value,
                                  allow_empty: true
                end

                protected

                # Minimum required fields with recurring_type subsequent request
                def recurring_type_subsequent_required_request_attributes
                  %i[transaction_id amount]
                end

              end
            end
          end
        end
      end
    end
  end
end
