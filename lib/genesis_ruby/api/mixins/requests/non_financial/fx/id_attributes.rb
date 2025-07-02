# frozen_string_literal: true

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module NonFinancial
          module Fx
            # ID Attributes mixin
            module IdAttributes

              attr_writer :id

              # Tier ID
              def id
                @id.to_s
              end

              # Required fields
              def id_required_fields
                [:id]
              end

            end
          end
        end
      end
    end
  end
end
