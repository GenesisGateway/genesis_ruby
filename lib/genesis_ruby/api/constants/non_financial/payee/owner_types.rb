# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module NonFinancial
        module Payee
          # Owner Types allowed values
          class OwnerTypes

            extend Mixins::Constants::Common

            # Company
            COMPANY = 'company'

            # Person
            PERSON = 'person'

            # Director
            DIRECTOR = 'director'

            # Ultimate Beneficial Owner
            ULTIMATE_BENEFICIAL_OWNER = 'ultimate_beneficial_owner'

          end
        end
      end
    end
  end
end
