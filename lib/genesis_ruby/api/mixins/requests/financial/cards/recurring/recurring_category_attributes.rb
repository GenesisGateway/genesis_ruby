require 'genesis_ruby/api/constants/transactions/parameters/recurring/categories'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module Cards
            module Recurring
              # Recurring Category Attributes
              module RecurringCategoryAttributes

                attr_reader :recurring_category

                # Specifies whether the recurring transaction is a subscription or standing order
                def recurring_category=(value)
                  allowed_options attribute:   __method__,
                                  allowed:     GenesisRuby::Api::Constants::Transactions::Parameters::Recurring::
                                      Categories.all,
                                  value:       value,
                                  allow_empty: true
                end

              end
            end
          end
        end
      end
    end
  end
end
