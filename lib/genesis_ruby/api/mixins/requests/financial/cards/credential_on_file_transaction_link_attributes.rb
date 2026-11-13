# frozen_string_literal: true

require 'genesis_ruby/api/constants/transactions/parameters/credential_on_files'
require 'genesis_ruby/api/constants/transactions/parameters/recurring/types'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          module Cards
            # Credential On File Transaction Link ID (Scheme Transaction Link ID) attributes mixin
            module CredentialOnFileTransactionLinkAttributes

              # Exact length of the Scheme Transaction Link ID
              CREDENTIAL_ON_FILE_TRANSACTION_LINK_ID_LENGTH = 22

              # Allowed format of the Scheme Transaction Link ID
              CREDENTIAL_ON_FILE_TRANSACTION_LINK_ID_FORMAT = /\A[A-Za-z0-9_-]{22}\z/.freeze

              attr_reader :credential_on_file_transaction_link_id

              # Scheme Transaction Link ID of the original transaction (Mastercard)
              def credential_on_file_transaction_link_id=(value)
                if value.nil? || value == ''
                  @credential_on_file_transaction_link_id = nil

                  return
                end

                validate_credential_on_file_transaction_link_id_format value

                @credential_on_file_transaction_link_id = value
              end

              protected

              # Validates the allowed transaction flow for credential_on_file_transaction_link_id upon document building
              def validate_credential_on_file_transaction_link_id
                return if credential_on_file_transaction_link_id.nil?
                return if non_referenced_subsequent_flow? || ucof_flow?

                raise ParameterError, 'credential_on_file_transaction_link_id is allowed only with recurring_type ' \
                                      'subsequent without reference_id or with credential_on_file merchant_unscheduled'
              end

              private

              # Raise InvalidArgumentError when the given value is not a valid Scheme Transaction Link ID
              def validate_credential_on_file_transaction_link_id_format(value)
                unless value.is_a? String
                  raise InvalidArgumentError, 'credential_on_file_transaction_link_id accepts only String values'
                end

                unless value.length == CREDENTIAL_ON_FILE_TRANSACTION_LINK_ID_LENGTH
                  raise InvalidArgumentError, 'credential_on_file_transaction_link_id value must be exactly ' \
                                              "#{CREDENTIAL_ON_FILE_TRANSACTION_LINK_ID_LENGTH} chars long."
                end

                return if CREDENTIAL_ON_FILE_TRANSACTION_LINK_ID_FORMAT.match? value

                raise InvalidArgumentError, 'credential_on_file_transaction_link_id accepts only Latin letters, ' \
                                            'digits, - and _ characters.'
              end

              # Subsequent recurring transaction without reference_id
              def non_referenced_subsequent_flow?
                recurring_type == Api::Constants::Transactions::Parameters::Recurring::Types::SUBSEQUENT &&
                  reference_id.to_s.empty?
              end

              # Unscheduled Credential On File transaction
              def ucof_flow?
                credential_on_file == Api::Constants::Transactions::Parameters::CredentialOnFiles::MERCHANT_UNSCHEDULED
              end

            end
          end
        end
      end
    end
  end
end
