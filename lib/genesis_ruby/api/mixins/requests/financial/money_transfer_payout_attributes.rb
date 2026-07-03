# frozen_string_literal: true

require 'genesis_ruby/api/constants/transactions/parameters/money_transfer/types'
require 'genesis_ruby/api/constants/transactions/parameters/money_transfer/sender_account_number_types'
require 'genesis_ruby/api/constants/transactions/parameters/money_transfer/purpose_of_payments'
require 'genesis_ruby/api/constants/transactions/parameters/money_transfer/source_of_funds'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          # Money Transfer Payout Attributes
          module MoneyTransferPayoutAttributes

            attr_accessor :money_transfer_sender_account_number,
                          :money_transfer_service_provider_name,
                          :money_transfer_sender_address_country,
                          :money_transfer_sender_address_city,
                          :money_transfer_sender_address_line,
                          :money_transfer_sender_address_state,
                          :money_transfer_sender_address_postal_code,
                          :money_transfer_receiver_first_name,
                          :money_transfer_receiver_last_name,
                          :money_transfer_receiver_address_country,
                          :money_transfer_receiver_address_city,
                          :money_transfer_receiver_address_line,
                          :money_transfer_receiver_address_state,
                          :money_transfer_receiver_address_postal_code,
                          :money_transfer_receiver_account_number,
                          :money_transfer_receiver_account_number_type

            attr_reader :money_transfer_type, :money_transfer_sender_account_number_type,
                        :money_transfer_purpose_of_payment, :money_transfer_source_of_funds

            # Money Transfer Type setter
            def money_transfer_type=(value)
              allowed_options(
                attribute:     __method__,
                allowed:       Api::Constants::Transactions::Parameters::MoneyTransfer::Types.all,
                value:         value,
                error_message: 'Invalid data for Money Transfer Type',
                allow_empty:   true
              )
            end

            # Money Transfer Sender Account Number Type setter
            def money_transfer_sender_account_number_type=(value)
              allowed_options(
                attribute:     __method__,
                allowed:       Api::Constants::Transactions::Parameters::MoneyTransfer::
                    SenderAccountNumberTypes.all,
                value:         value,
                error_message: 'Invalid data for Money Transfer Sender Account Number Type',
                allow_empty:   true
              )
            end

            # Money Transfer Purpose of Payment setter
            def money_transfer_purpose_of_payment=(value)
              allowed_options(
                attribute:     __method__,
                allowed:       Api::Constants::Transactions::Parameters::MoneyTransfer::PurposeOfPayments.all,
                value:         value,
                error_message: 'Invalid data for Money Transfer Purpose of Payment',
                allow_empty:   true
              )
            end

            # Money Transfer Source of Funds setter
            def money_transfer_source_of_funds=(value)
              allowed_options(
                attribute:     __method__,
                allowed:       Api::Constants::Transactions::Parameters::MoneyTransfer::SourceOfFunds.all,
                value:         value,
                error_message: 'Invalid data for Money Transfer Source of Funds',
                allow_empty:   true
              )
            end

            # Money Transfer Sender Birth Date accessor
            def money_transfer_sender_birth_date
              @money_transfer_sender_birth_date&.strftime(
                Api::Constants::DateTimeFormats::DD_MM_YYYY_L_HYPHENS
              )
            end

            # Money Transfer Sender Birth Date setter
            def money_transfer_sender_birth_date=(value)
              parse_date attribute: __method__, value: value, allow_empty: true
            end

            protected

            # Money Transfer Payout Attributes Structure
            def money_transfer_payout_attributes_structure # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
              {
                type:                       money_transfer_type,
                sender_account_number:      money_transfer_sender_account_number,
                sender_birth_date:          money_transfer_sender_birth_date,
                service_provider_name:      money_transfer_service_provider_name,
                sender_account_number_type: money_transfer_sender_account_number_type,
                purpose_of_payment:         money_transfer_purpose_of_payment,
                source_of_funds:            money_transfer_source_of_funds,
                sender_address:             {
                  country:     money_transfer_sender_address_country,
                  city:        money_transfer_sender_address_city,
                  line:        money_transfer_sender_address_line,
                  state:       money_transfer_sender_address_state,
                  postal_code: money_transfer_sender_address_postal_code
                },
                receiver:                   {
                  first_name:          money_transfer_receiver_first_name,
                  last_name:           money_transfer_receiver_last_name,
                  country:             money_transfer_receiver_address_country,
                  city:                money_transfer_receiver_address_city,
                  line:                money_transfer_receiver_address_line,
                  state:               money_transfer_receiver_address_state,
                  postal_code:         money_transfer_receiver_address_postal_code,
                  account_number:      money_transfer_receiver_account_number,
                  account_number_type: money_transfer_receiver_account_number_type
                }
              }
            end

          end
        end
      end
    end
  end
end
