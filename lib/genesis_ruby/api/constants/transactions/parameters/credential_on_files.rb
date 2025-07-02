# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          # Credential On Files allowed values
          class CredentialOnFiles

            extend Mixins::Constants::Common

            # Initial transaction used to store payment credentials for future customer initiated payments while
            # processing. Required for external tokenization, and optional for gateway-based tokenization
            INITIAL_CUSTOMER_INITIATED    = 'initial_customer_initiated'

            # Subsequent customer initiated transaction using previously stored payment credentials.
            # Required for external tokenization, and optional for gateway-based tokenization
            SUBSEQUENT_CUSTOMER_INITIATED = 'subsequent_customer_initiated'

            # For UCOF transaction, the scheme transaction identifier of the initial transaction must be sent in
            # the transaction request. For MasterCard or Maestro UCOF, the scheme settlement date in MMDD format
            # (e.g. 0107) of the initial transaction must be sent in the transaction request.
            MERCHANT_UNSCHEDULED          = 'merchant_unscheduled'

          end
        end
      end
    end
  end
end
