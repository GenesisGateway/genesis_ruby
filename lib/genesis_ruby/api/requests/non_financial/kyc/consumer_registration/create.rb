module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Kyc
          module ConsumerRegistration
            # Create Consumer Registration Request class for KYC Non-Financial API services
            class Create < Api::Requests::Base::NonFinancial::Kyc::Base

              include Api::Mixins::Requests::NonFinancial::Kyc::CustomerInformationAttributes

              attr_accessor :session_id, :customer_unique_id, :transaction_unique_id, :customer_phone_number,
                            :service_language, :security_code, :service_type, :customer_username,
                            :customer_registration_date, :customer_registration_ip_address,
                            :customer_registration_device_id, :third_party_device_id, :device_fingerprint,
                            :bonus_code, :bonus_submission_date, :bonus_amount, :merchant_website,
                            :how_did_you_hear, :affiliate_id, :rule_context
              attr_writer   :profile_action_type, :device_fingerprint_type, :profile_current_status, :industry_type

              # Initializes the Create Consumer Registration Request
              def initialize(configuration, _builder_interface = nil)
                super configuration

                self.request_path = 'create_consumer'
              end

              # Returns device_fingerprint_type as an integer
              def device_fingerprint_type
                @device_fingerprint_type&.to_i
              end

              # Returns profile_action_type as an integer
              def profile_action_type
                @profile_action_type&.to_i
              end

              # Returns profile_current_status as an integer
              def profile_current_status
                @profile_current_status&.to_i
              end

              # Returns industry_type as an integer
              def industry_type
                @industry_type&.to_i
              end

              protected

              # Sets the request field validations
              def init_field_validations # rubocop:disable Metrics/MethodLength
                super

                required_fields.push *%i[
                  customer_unique_id
                  customer_registration_date
                  customer_registration_ip_address
                ] + customer_information_required_fields

                field_values.merge! device_fingerprint_type: [1, 2, 3],
                                    profile_action_type:     [1, 2],
                                    profile_current_status:
                                      GenesisRuby::Api::Constants::NonFinancial::Kyc::ProfileCurrentStatuses.all,
                                    industry_type:           [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
                field_values.merge! customer_information_required_field_values
              end

              # Defines the request structure
              def request_structure # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
                {
                  session_id:                       session_id,
                  customer_username:                customer_username,
                  customer_unique_id:               customer_unique_id,
                  customer_registration_date:       customer_registration_date,
                  customer_registration_ip_address: customer_registration_ip_address,
                  customer_registration_device_id:  customer_registration_device_id,
                  customer_information:             customer_information_structure,
                  third_party_device_id:            third_party_device_id,
                  device_fingerprint:               device_fingerprint,
                  device_fingerprint_type:          device_fingerprint_type,
                  profile_action_type:              profile_action_type,
                  profile_current_status:           profile_current_status,
                  bonus_code:                       bonus_code,
                  bonus_submission_date:            bonus_submission_date,
                  bonus_amount:                     bonus_amount,
                  merchant_website:                 merchant_website,
                  industry_type:                    industry_type,
                  how_did_you_hear:                 how_did_you_hear,
                  affiliate_id:                     affiliate_id,
                  rule_context:                     rule_context
                }
              end

            end
          end
        end
      end
    end
  end
end
