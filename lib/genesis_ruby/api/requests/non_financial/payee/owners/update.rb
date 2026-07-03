# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Payee
          module Owners
            # Update an existing Owner.
            class Update < Base::NonFinancial::Payee::Base

              attr_accessor :owner_unique_id, :owner_name, :owner_country, :owner_date,
                            :notification_url, :registration_number, :owner_address

              # Update Owner initialization
              def initialize(configuration, _builder_interface = nil)
                super configuration

                self.request_path = 'payee/owners/:owner_unique_id'

                init_patch_configuration
              end

              protected

              # Sets the request field validations
              def init_field_validations
                super

                required_fields.push *%i[
                  owner_unique_id
                ]

                field_values.merge! owner_country: GenesisRuby::Utils::Country::COUNTRIES.keys
              end

              # Returns the request structure
              def request_structure
                {
                  owner: {
                    name:                owner_name,
                    country:             owner_country,
                    date:                owner_date,
                    notification_url:    notification_url,
                    registration_number: registration_number,
                    address:             owner_address
                  }
                }
              end

              # Override API endpoint configuration
              def process_request_parameters
                super

                processed_path = request_path.dup.gsub(':owner_unique_id', owner_unique_id.to_s)

                init_api_service_configuration request_path: processed_path, include_token: false
              end

            end
          end
        end
      end
    end
  end
end
