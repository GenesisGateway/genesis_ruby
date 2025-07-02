# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module CashPayments
            # Company Types allowed values
            class CompanyTypes

              extend Api::Mixins::Constants::Common

              # SA
              SA = 0

              # LTDA
              LTDA = 1

              # MEI
              MEI = 2

              # ME
              ME = 3

              # EIRELI
              EIRELI = 4

              # CONDOMINIUM
              CONDOMINIUM = 5

              # Closed
              CLOSED = 6

              # SIMPLE EIRELI
              SIMPLE_EIRELI = 7

              # OUTROS
              OUTROS = 8

            end
          end
        end
      end
    end
  end
end
