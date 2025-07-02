# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Payee
          module Account
            # Create a Account related to a specific Payee.
            class Create < Base::Versioned

              PAYEE_ACCOUNT_TYPE_IBAN = 'iban'
              PAYEE_ACCOUNT_TYPE_BANK = 'bank'

              attr_accessor :payee_unique_id, :payee_account_type, :payee_account_number, :payee_account_country,
                            :payee_account_institution_code

              # Retrieve Payee initialization
              def initialize(configuration, _builder_interface = nil)
                super configuration

                self.request_path = 'payee/:payee_unique_id/account'
              end

              protected

              # Sets the request field validations
              def init_field_validations # rubocop:disable Metrics/MethodLength
                super

                required_fields.push *%i[
                  payee_unique_id payee_account_type payee_account_number
                ]
                field_values.merge! payee_account_type:    [PAYEE_ACCOUNT_TYPE_IBAN, PAYEE_ACCOUNT_TYPE_BANK],
                                    payee_account_country: GenesisRuby::Utils::Country::COUNTRIES.keys
                field_value_dependencies.merge!(
                  {
                    payee_account_type: {
                      PAYEE_ACCOUNT_TYPE_BANK => %i[payee_account_institution_code]
                    }
                  }
                )
              end

              # Returns the request structure
              def request_structure
                {
                  account: {
                    type:             payee_account_type,
                    number:           payee_account_number,
                    country:          payee_account_country,
                    institution_code: payee_account_institution_code

                  }
                }
              end

              # Override API endpoint configuration
              def process_request_parameters
                super

                processed_path = request_path.dup.gsub(':payee_unique_id', payee_unique_id.to_s)

                init_api_service_configuration request_path: processed_path, include_token: false
              end

            end
          end
        end
      end
    end
  end
end
