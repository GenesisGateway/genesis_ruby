# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module NonFinancial
        module Kyc
          # Document Types allowed values
          class DocumentTypes

            extend Mixins::Constants::Common

            # SSN
            SSN = 0

            # Passport Registry
            PASSPORT_REGISTRY = 1

            # Personal ID / National ID
            PERSONAL_ID = 2

            # Identity Card
            IDENTITY_CARD = 3

            # Driver License
            DRIVER_LICENSE = 4

            # Travel Document
            TRAVEL_DOCUMENT = 8

            # Residence Permit
            RESIDENCE_PERMIT = 12

            # Identity Certificate
            IDENTITY_CERTIFICATE = 13

            # Registro Federal de Contribuyentes
            FEDERAL_REGISTER = 16

            # Credencial de Elector
            ELECTRON_CREDENTIALS = 17

            # CPF
            CPF = 18

          end
        end
      end
    end
  end
end
