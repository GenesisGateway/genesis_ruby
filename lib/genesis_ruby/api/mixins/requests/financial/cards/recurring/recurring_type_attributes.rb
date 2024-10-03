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

                attr_accessor :recurring_type

                protected

                # Recurring Type for Initial transaction types validation structure
                def recurring_type_initial_field_values_validation_structure
                  {
                    recurring_type: Api::Constants::Transactions::Parameters::Recurring::Types.all -
                      [Api::Constants::Transactions::Parameters::Recurring::Types::SUBSEQUENT]
                  }
                end

                # Recurring Type Field Value validation structure
                def recurring_type_field_values_validation_structure
                  {
                    recurring_type: Api::Constants::Transactions::Parameters::Recurring::Types.all
                  }
                end

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
