module GenesisRuby
  module Api
    module Mixins
      module Requests
        module NonFinancial
          module BillingApi
            # Sort Attributes mixin
            module SortAttributes

              attr_accessor :sort_by_field, :sort_by_direction

            end
          end
        end
      end
    end
  end
end
