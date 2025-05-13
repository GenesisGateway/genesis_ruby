require 'genesis_ruby/api/constants/transactions/parameters/customer_identification/customer_identification_owner'
require 'genesis_ruby/api/constants/transactions/parameters/customer_identification/customer_identification_type'
require 'genesis_ruby/api/constants/transactions/parameters/customer_identification/customer_identification_subtype'
require 'genesis_ruby/utils/country'

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          # Customer Identification Attributes
          module CustomerIdentificationAttributes

            attr_accessor :customer_identification_document_id

            attr_reader   :customer_identification_owner, :customer_identification_type,
                          :customer_identification_subtype, :customer_identification_issuing_country

            # Customer Identification Owner
            def customer_identification_owner=(value)
              allowed_options(
                attribute: __method__,
                allowed:
                  GenesisRuby::Api::Constants::Transactions::Parameters::CustomerIdentification::CustomerIdentificationOwner.all, # rubocop:disable Layout/LineLength
                value: value,
                error_message: 'Invalid data for Customer Identification Document Owner',
                allow_empty: true
              )
            end

            # Customer Identification Type
            def customer_identification_type=(value)
              allowed_options(
                attribute: __method__,
                allowed:
                  GenesisRuby::Api::Constants::Transactions::Parameters::CustomerIdentification::CustomerIdentificationType.all, # rubocop:disable Layout/LineLength
                value: value,
                error_message: 'Invalid data for Customer Identification Document Type',
                allow_empty: true
              )
            end

            # Customer Identification Issuing Country
            def customer_identification_issuing_country=(value)
              allowed_options(
                attribute: __method__,
                allowed: GenesisRuby::Utils::Country::COUNTRIES.keys,
                value: value,
                error_message: 'Invalid country code for Document issuer country',
                allow_empty: true
              )
            end

            # Customer Identification Document Subtype
            def customer_identification_subtype=(value)
              allowed_options(
                attribute: __method__,
                allowed: GenesisRuby::Api::Constants::Transactions::Parameters::CustomerIdentification::CustomerIdentificationSubtype.all, # rubocop:disable Layout/LineLength
                value: value,
                error_message: 'Invalid value for Customer Identification Document Subtype',
                allow_empty: true
              )
            end

            protected

            def customer_identification_attributes_structure
              {
                owner:           customer_identification_owner,
                type:            customer_identification_type,
                subtype:         customer_identification_subtype,
                document_id:     customer_identification_document_id,
                issuing_country: customer_identification_issuing_country
              }
            end

          end
        end
      end
    end
  end
end
