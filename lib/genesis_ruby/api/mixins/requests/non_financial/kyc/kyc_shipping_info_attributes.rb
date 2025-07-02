# frozen_string_literal: true

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module NonFinancial
          module Kyc
            # Mixin KycShippingInfoAttributes for KYC Non-Financial API services
            module KycShippingInfoAttributes

              attr_accessor :shipping_first_name, :shipping_last_name, :shipping_address1, :shipping_address2,
                            :shipping_city, :shipping_province, :shipping_zip_code
              attr_reader   :shipping_customer_email, :shipping_country, :shipping_phone1

              # Sets the shipping customer email
              def shipping_customer_email=(value)
                error_message = format(
                  'Invalid value given for %{attribute}',
                  attribute: __method__
                )

                raise GenesisRuby::InvalidArgumentError, error_message unless value.nil? || value =~ /\A.+@.+\..+\Z/

                @shipping_customer_email = value
              end

              # Sets the shipping country attribute
              def shipping_country=(value)
                allowed_options(
                  attribute: __method__,
                  allowed: GenesisRuby::Utils::Country::COUNTRIES.keys,
                  value: value,
                  error_message: 'Invalid country code for Create Transaction shipping country',
                  allow_empty: true
                )
              end

              # Sets the shipping_gender attribute
              def shipping_gender=(value)
                allowed_options(
                  attribute: __method__,
                  allowed: Api::Constants::NonFinancial::Kyc::Genders.all,
                  value: value,
                  error_message: 'Invalid gender for Create Transaction shipping gender',
                  allow_empty: true
                )
              end

              # Sets the shipping_phone1 attribute
              def shipping_phone1=(value)
                error_message = format(
                  'Invalid value given for %{attribute}',
                  attribute: __method__
                )
                raise GenesisRuby::InvalidArgumentError, error_message unless value.nil? || value =~ /^\d+$/

                @shipping_phone1 = value
              end

              protected

              # Returns KYC Shipping Information structure
              def kyc_shipping_info_structure # rubocop:disable Metrics/MethodLength
                {
                  first_name:     shipping_first_name,
                  last_name:      shipping_last_name,
                  customer_email: shipping_customer_email,
                  address1:       shipping_address1,
                  address2:       shipping_address2,
                  city:           shipping_city,
                  province:       shipping_province,
                  zip_code:       shipping_zip_code,
                  country:        shipping_country,
                  phone1:         shipping_phone1
                }
              end

            end
          end
        end
      end
    end
  end
end
