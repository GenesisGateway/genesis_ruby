# frozen_string_literal: true

require 'genesis_ruby/api/constants/non_financial/payee/owner_types'

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Payee
          module Owners
            # Create an Owner entity.
            class Create < Base::NonFinancial::Payee::Base

              attr_accessor :owner_type, :owner_name, :owner_country, :owner_date,
                            :notification_url, :registration_number, :owner_address,
                            :payees, :owners

              # Create Owner initialization
              def initialize(configuration, _builder_interface = nil)
                super configuration

                self.request_path = 'payee/owners'
              end

              protected

              # Sets the request field validations
              def init_field_validations
                super

                required_fields.push *%i[
                  owner_type
                                       owner_name
                                       owner_country
                ]

                field_values.merge! owner_type: GenesisRuby::Api::Constants::NonFinancial::Payee::OwnerTypes.all,
                                    owner_country: GenesisRuby::Utils::Country::COUNTRIES.keys
              end

              # Returns the request structure
              def request_structure # rubocop:disable Metrics/MethodLength
                {
                  owner: {
                    type:                owner_type,
                    name:                owner_name,
                    country:             owner_country,
                    date:                owner_date,
                    notification_url:    notification_url,
                    registration_number: registration_number,
                    address:             owner_address,
                    payees:              payees,
                    owners:              owners
                  }
                }
              end

              # Override API endpoint configuration
              def process_request_parameters
                super

                init_api_service_configuration request_path: request_path, include_token: false
              end

            end
          end
        end
      end
    end
  end
end
