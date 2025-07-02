# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module CashPayments
            # Genders allowed values
            class Genders

              extend Mixins::Constants::Common

              # Male
              MALE = 0

              # Female
              FEMALE = 1

              # Other
              OTHER = 2

            end
          end
        end
      end
    end
  end
end
