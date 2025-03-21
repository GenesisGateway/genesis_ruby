module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module Cards
            # Installment shared attributes mixin
            module InstallmentAttributes

              attr_accessor :installment_plan_id, :installment_plan_reference

            end
          end
        end
      end
    end
  end
end
