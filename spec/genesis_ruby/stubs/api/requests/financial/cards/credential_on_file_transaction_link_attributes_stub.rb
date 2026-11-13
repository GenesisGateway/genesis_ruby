# frozen_string_literal: true

module GenesisSpec
  module Stubs
    module Api
      module Requests
        module Financial
          module Cards
            # Credential on file transaction link attributes stub
            class CredentialOnFileTransactionLinkAttributesStub

              include GenesisRuby::Api::Mixins::Requests::Financial::Cards::CredentialOnFileTransactionLinkAttributes

              attr_accessor :recurring_type, :reference_id, :credential_on_file

              public :validate_credential_on_file_transaction_link_id

            end
          end
        end
      end
    end
  end
end
