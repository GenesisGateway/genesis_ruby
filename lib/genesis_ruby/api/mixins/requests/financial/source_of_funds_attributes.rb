require 'genesis_ruby/api/constants/transactions/parameters/source_of_funds'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          # Source of Funds Attributes
          module SourceOfFundsAttributes

            attr_reader :source_of_funds

            # Source of Funds setter
            def source_of_funds=(value)
              allowed_options(
                attribute: __method__,
                allowed: GenesisRuby::Api::Constants::Transactions::Parameters::SourceOfFunds.all,
                value: value,
                error_message: 'Invalid data for Source of Funds',
                allow_empty: true
              )
            end

            protected

            # Source of Funds attributes structure
            def source_of_funds_attributes_structure
              {
                source_of_funds: source_of_funds
              }
            end

          end
        end
      end
    end
  end
end
