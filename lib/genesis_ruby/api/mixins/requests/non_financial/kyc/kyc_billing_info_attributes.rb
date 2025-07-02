# frozen_string_literal: true

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module NonFinancial
          module Kyc
            # Mixin KycBillingInfoAttributes for KYC Non-Financial API services
            module KycBillingInfoAttributes

              attr_accessor :billing_first_name, :billing_last_name, :billing_address1, :billing_address2,
                            :billing_city, :billing_province, :billing_zip_code, :billing_birth_date
              attr_reader   :billing_customer_email, :billing_country, :billing_gender, :billing_phone1

              # Sets the billing_customer_email attribute
              def billing_customer_email=(value)
                error_message = format(
                  'Invalid value given for %{attribute}',
                  attribute: __method__
                )

                raise GenesisRuby::InvalidArgumentError, error_message unless value.nil? || value =~ /\A.+@.+\..+\Z/

                @billing_customer_email = value
              end

              # Sets the billing_country attribute
              def billing_country=(value)
                allowed_options(
                  attribute: __method__,
                  allowed: GenesisRuby::Utils::Country::COUNTRIES.keys,
                  value: value,
                  error_message: 'Invalid country code for Create Transaction billing country',
                  allow_empty: true
                )
              end

              # Sets the billing_gender attribute
              def billing_gender=(value)
                allowed_options(
                  attribute: __method__,
                  allowed: Api::Constants::NonFinancial::Kyc::Genders.all,
                  value: value,
                  error_message: 'Invalid gender for Create Transaction billing gender',
                  allow_empty: true
                )
              end

              # Sets the billing_phone1 attribute
              def billing_phone1=(value)
                error_message = format(
                  'Invalid value given for %{attribute}',
                  attribute: __method__
                )
                raise GenesisRuby::InvalidArgumentError, error_message unless value.nil? || value =~ /^\d+$/

                @billing_phone1 = value
              end

              protected

              # Returns KYC billing information structure
              def kyc_billing_info_structure # rubocop:disable Metrics/MethodLength
                {
                  first_name:     billing_first_name,
                  last_name:      billing_last_name,
                  customer_email: billing_customer_email,
                  address1:       billing_address1,
                  address2:       billing_address2,
                  city:           billing_city,
                  province:       billing_province,
                  zip_code:       billing_zip_code,
                  country:        billing_country,
                  phone1:         billing_phone1,
                  birth_date:     billing_birth_date,
                  gender:         billing_gender
                }
              end

            end
          end
        end
      end
    end
  end
end
