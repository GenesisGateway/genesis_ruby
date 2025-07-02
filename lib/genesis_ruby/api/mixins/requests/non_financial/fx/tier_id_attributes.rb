# frozen_string_literal: true

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module NonFinancial
          module Fx
            # Tier ID Attributes mixin
            module TierIdAttributes

              attr_writer :tier_id

              # Identification of the tier
              def tier_id
                @tier_id.to_s
              end

              # Required fields
              def tier_id_required_fields
                [:tier_id]
              end

            end
          end
        end
      end
    end
  end
end
