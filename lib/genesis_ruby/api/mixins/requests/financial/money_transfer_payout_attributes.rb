# frozen_string_literal: true

require 'genesis_ruby/api/constants/transactions/parameters/funding/person_types'
require 'genesis_ruby/api/constants/transactions/parameters/money_transfer/types'
require 'genesis_ruby/api/constants/transactions/parameters/money_transfer/sender_account_number_types'
require 'genesis_ruby/api/constants/transactions/parameters/money_transfer/source_of_funds'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          # Money Transfer Payout Attributes
          module MoneyTransferPayoutAttributes

            attr_accessor :money_transfer_sender_account_number, :money_transfer_service_provider_name,
                          :money_transfer_sender_address_first_name, :money_transfer_sender_address_last_name,
                          :money_transfer_sender_address_country, :money_transfer_sender_address_city,
                          :money_transfer_sender_address_zip_code, :money_transfer_sender_address_address1,
                          :money_transfer_sender_address_state, :money_transfer_receiver_first_name,
                          :money_transfer_receiver_last_name, :money_transfer_receiver_country,
                          :money_transfer_receiver_city, :money_transfer_receiver_zip_code,
                          :money_transfer_receiver_address1, :money_transfer_receiver_state

            attr_reader :money_transfer_type, :money_transfer_sender_address_type, :money_transfer_receiver_type,
                        :money_transfer_sender_account_number_type, :money_transfer_source_of_funds

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

            # Money Transfer Sender Address Person Type setter
            def money_transfer_sender_address_type=(value)
              allowed_options(
                attribute:     __method__,
                allowed:       Api::Constants::Transactions::Parameters::Funding::PersonTypes.all,
                value:         value,
                error_message: 'Invalid data for Money Transfer Sender Address Type',
                allow_empty:   true
              )
            end

            # Money Transfer Receiver Person Type setter
            def money_transfer_receiver_type=(value)
              allowed_options(
                attribute:     __method__,
                allowed:       Api::Constants::Transactions::Parameters::Funding::PersonTypes.all,
                value:         value,
                error_message: 'Invalid data for Money Transfer Receiver Type',
                allow_empty:   true
              )
            end

            # Money Transfer Sender Account Number Type setter
            def money_transfer_sender_account_number_type=(value)
              allowed_options(
                attribute:     __method__,
                allowed:       Api::Constants::Transactions::Parameters::MoneyTransfer::SenderAccountNumberTypes.all,
                value:         value,
                error_message: 'Invalid data for Money Transfer Sender Account Number Type',
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
                sender_address:             {
                  type:       money_transfer_sender_address_type,
                  first_name: money_transfer_sender_address_first_name,
                  last_name:  money_transfer_sender_address_last_name,
                  country:    money_transfer_sender_address_country,
                  city:       money_transfer_sender_address_city,
                  zip_code:   money_transfer_sender_address_zip_code,
                  address1:   money_transfer_sender_address_address1,
                  state:      money_transfer_sender_address_state
                },
                receiver:                   {
                  type:       money_transfer_receiver_type,
                  first_name: money_transfer_receiver_first_name,
                  last_name:  money_transfer_receiver_last_name,
                  country:    money_transfer_receiver_country,
                  city:       money_transfer_receiver_city,
                  zip_code:   money_transfer_receiver_zip_code,
                  address1:   money_transfer_receiver_address1,
                  state:      money_transfer_receiver_state
                },
                sender_account_number_type: money_transfer_sender_account_number_type,
                source_of_funds:            money_transfer_source_of_funds
              }
            end

          end
        end
      end
    end
  end
end
