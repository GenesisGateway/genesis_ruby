# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module Funding
            # Funding Person Types allowed values
            class PersonTypes

              extend Api::Mixins::Constants::Common

              # Natural person (individual)
              NATURAL = 'natural'

              # Legal person (company or other legal entity)
              LEGAL   = 'legal'

            end
          end
        end
      end
    end
  end
end
