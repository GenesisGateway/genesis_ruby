require 'genesis_ruby/api/constants/transactions/parameters/funding/business_application_identifier_types'
require 'genesis_ruby/api/constants/transactions/parameters/funding/identifier_types'
require 'genesis_ruby/api/constants/transactions/parameters/funding/receiver_account_types'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          # Mixin Funding Attributes
          module FundingAttributes

            attr_accessor :funding_identifier_type, :funding_business_application_identifier,
                          :funding_receiver_first_name, :funding_receiver_last_name, :funding_receiver_country,
                          :funding_receiver_account_number, :funding_receiver_account_number_type,
                          :funding_receiver_address, :funding_receiver_state, :funding_receiver_city,
                          :funding_sender_name, :funding_sender_reference_number, :funding_sender_country,
                          :funding_sender_address, :funding_sender_state, :funding_sender_city

            protected

            # Provide a hash with the funding attributes field allowed values
            def funding_attributes_field_validations
              {
                funding_identifier_type:                 Api::Constants::Transactions::Parameters::Funding::
                    IdentifierTypes.all,
                funding_business_application_identifier: Api::Constants::Transactions::Parameters::Funding::
                    BusinessApplicationIdentifierTypes.all,
                funding_receiver_account_number_type:    Api::Constants::Transactions::Parameters::Funding::
                    ReceiverAccountTypes.all
              }
            end

            # Funding Attributes Structure
            def funding_attributes_structure # rubocop:disable Metrics/MethodLength
              {
                identifier_type:                 funding_identifier_type,
                business_application_identifier: funding_business_application_identifier,
                receiver:                        {
                  first_name:          funding_receiver_first_name,
                  last_name:           funding_receiver_last_name,
                  country:             funding_receiver_country,
                  account_number:      funding_receiver_account_number,
                  account_number_type: funding_receiver_account_number_type,
                  address:             funding_receiver_address,
                  state:               funding_receiver_state,
                  city:                funding_receiver_city
                },
                sender:                          {
                  name:             funding_sender_name,
                  reference_number: funding_sender_reference_number,
                  country:          funding_sender_country,
                  address:          funding_sender_address,
                  state:            funding_sender_state,
                  city:             funding_sender_city
                }
              }
            end

          end
        end
      end
    end
  end
end
