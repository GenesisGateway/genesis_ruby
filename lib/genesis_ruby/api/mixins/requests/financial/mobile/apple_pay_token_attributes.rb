require 'json'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module Mobile
            # Apple Pay Token Attributes mixin
            module ApplePayTokenAttributes

              attr_accessor :token_version, :token_data, :token_signature,
                            :token_ephemeral_public_key, :token_public_key_hash, :token_transaction_id,
                            :token_display_name, :token_network, :token_type, :token_transaction_identifier,
                            :token_application_data, :token_wrapped_key

              # Apple Pay token structure
              def payment_token_structure # rubocop:disable Metrics/MethodLength
                structure = {
                  paymentData:           {
                    version:   token_version,
                    data:      token_data,
                    signature: token_signature,
                    header:    {
                      applicationData:    token_application_data,
                      ephemeralPublicKey: token_ephemeral_public_key,
                      wrappedKey:         token_wrapped_key,
                      publicKeyHash:      token_public_key_hash,
                      transactionId:      token_transaction_id
                    }
                  },
                  paymentMethod:         {
                    displayName: token_display_name,
                    network:     token_network,
                    type:        token_type
                  },
                  transactionIdentifier: token_transaction_identifier
                }

                GenesisRuby::Utils::Common.deep_compact!(structure)

                structure.to_json
              end

            end
          end
        end
      end
    end
  end
end
