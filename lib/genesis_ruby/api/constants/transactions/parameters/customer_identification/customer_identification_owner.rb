# frozen_string_literal: true

module GenesisRuby
  module Api
    module Constants
      module Transactions
        module Parameters
          module CustomerIdentification
            # Specifies if the document ID belongs to the sender or the receiver of the OCT
            class CustomerIdentificationOwner

              extend Api::Mixins::Constants::Common

              # Document ID belongs to
              SENDER   = 'sender'

              # Document ID belongs to
              RECEIVER = 'receiver'

            end
          end
        end
      end
    end
  end
end
