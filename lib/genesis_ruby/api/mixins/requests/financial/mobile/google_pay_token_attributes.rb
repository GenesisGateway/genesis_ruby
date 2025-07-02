# frozen_string_literal: true

require 'json'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module Mobile
            # Google Pay Token Attributes
            module GooglePayTokenAttributes

              attr_accessor :token_signature, :token_signed_key, :token_protocol_version, :token_signed_message

              # Google Pay Token Signatures accessor
              def token_signatures
                @token_signatures ||= []
              end

              # Google Pay Token Signatures accessor
              def token_signatures=(value)
                if !value.is_a?(Array) && !value.nil?
                  raise InvalidArgumentError, 'Invalid value given for Token Signatures. Accept array'
                end

                @token_signatures = value
              end

              def google_pay_token_structure # rubocop:disable Metrics/MethodLength
                structure = {
                  signature:              token_signature,
                  protocolVersion:        token_protocol_version,
                  signedMessage:          token_signed_message,
                  intermediateSigningKey: {
                    signedKey:  token_signed_key,
                    signatures: token_signatures
                  }
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
