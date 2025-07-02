# frozen_string_literal: true

require 'genesis_ruby/api/constants/non_financial/kyc/profile_current_statuses'

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Kyc
          module ConsumerRegistration
            # Update Consumer Registration Request class for KYC Non-Financial API services
            class Update < Api::Requests::Base::NonFinancial::Kyc::Base

              attr_accessor :reference_id, :profile_current_status, :status_reason

              def initialize(configuration, _builder_interface = nil)
                super configuration

                self.request_path = 'update_consumer'
              end

              protected

              # Sets the request field validations
              def init_field_validations
                super

                required_fields.push *%i[
                  reference_id
                  profile_current_status
                ]

                field_values.merge! profile_current_status:
                  GenesisRuby::Api::Constants::NonFinancial::Kyc::ProfileCurrentStatuses.all
              end

              # Defines the request structure
              def request_structure
                {
                  reference_id:           reference_id,
                  profile_current_status: profile_current_status,
                  status_reason:          status_reason
                }
              end

            end
          end
        end
      end
    end
  end
end
