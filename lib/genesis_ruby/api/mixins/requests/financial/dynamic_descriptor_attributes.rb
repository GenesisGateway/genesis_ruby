# frozen_string_literal: true

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module Financial
          # Dynamic Descriptor Attributes
          module DynamicDescriptorAttributes

            attr_reader :dynamic_descriptor_merchant_name, :dynamic_descriptor_merchant_city,
                        :dynamic_descriptor_sub_merchant_id, :dynamic_descriptor_merchant_country,
                        :dynamic_descriptor_merchant_state, :dynamic_descriptor_merchant_zip_code,
                        :dynamic_descriptor_merchant_address, :dynamic_descriptor_merchant_url,
                        :dynamic_descriptor_merchant_phone, :dynamic_descriptor_merchant_geo_coordinates,
                        :dynamic_descriptor_merchant_service_city, :dynamic_descriptor_merchant_service_country,
                        :dynamic_descriptor_merchant_service_state, :dynamic_descriptor_merchant_service_zip_code,
                        :dynamic_descriptor_merchant_service_phone, :dynamic_descriptor_merchant_service_geo_coordinates

            # Allows to dynamically override the charge descriptor
            def dynamic_descriptor_merchant_name=(value)
              limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 25
            end

            # Allows to dynamically override the merchant city
            def dynamic_descriptor_merchant_city=(value)
              limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 13
            end

            # Allows to dynamically override the sub-merchant ID
            def dynamic_descriptor_sub_merchant_id=(value)
              limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 15
            end

            # Allows to dynamically override the merchant country
            def dynamic_descriptor_merchant_country=(value)
              limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 3
            end

            # Allows to dynamically override the merchant subdivision code
            def dynamic_descriptor_merchant_state=(value)
              limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 3
            end

            # Allows to dynamically override the merchant zip/postal code
            def dynamic_descriptor_merchant_zip_code=(value)
              limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 10
            end

            #  Allows to dynamically override the merchant address
            def dynamic_descriptor_merchant_address=(value)
              limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 48
            end

            # Allows to dynamically override the merchant URL
            def dynamic_descriptor_merchant_url=(value)
              limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 60
            end

            # Allows to dynamically override the merchant phone number
            def dynamic_descriptor_merchant_phone=(value)
              limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 16
            end

            # Merchant geographic coordinates. Length of geographic coordinates is a range of 15-20 symbols.
            # Latitude and Longitude separated by a comma. Example: `40.73061,-73.93524`
            def dynamic_descriptor_merchant_geo_coordinates=(value)
              limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, min: 15, max: 20
            end

            # Allows to dynamically override the merchant service city
            def dynamic_descriptor_merchant_service_city=(value)
              limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 13
            end

            # Allows to dynamically override the merchant service country
            def dynamic_descriptor_merchant_service_country=(value)
              limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 3
            end

            # Allows to dynamically override the merchant service subdivision code
            def dynamic_descriptor_merchant_service_state=(value)
              limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 3
            end

            # Allows to dynamically override the merchant service zip/postal
            def dynamic_descriptor_merchant_service_zip_code=(value)
              limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 10
            end

            # Allows to dynamically override the merchant service phone number
            def dynamic_descriptor_merchant_service_phone=(value)
              limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, max: 16
            end

            # Merchant service geographic coordinates. Length of geographic coordinates is a range of 15-20 symbols.
            # Latitude and Longitude separated by a comma. Example: `40.73061,-73.93524`
            def dynamic_descriptor_merchant_service_geo_coordinates=(value)
              limited_string attribute: __method__, value: value.to_s.empty? ? nil : value.to_s, min: 15, max: 20
            end

            protected

            # Dynamic Descriptor Params structure
            def dynamic_descriptor_structure # rubocop:disable Metrics/MethodLength
              {
                merchant_name:                    dynamic_descriptor_merchant_name,
                merchant_city:                    dynamic_descriptor_merchant_city,
                sub_merchant_id:                  dynamic_descriptor_sub_merchant_id,
                merchant_country:                 dynamic_descriptor_merchant_country,
                merchant_state:                   dynamic_descriptor_merchant_state,
                merchant_zip_code:                dynamic_descriptor_merchant_zip_code,
                merchant_address:                 dynamic_descriptor_merchant_address,
                merchant_url:                     dynamic_descriptor_merchant_url,
                merchant_phone:                   dynamic_descriptor_merchant_phone,
                merchant_geo_coordinates:         dynamic_descriptor_merchant_geo_coordinates,
                merchant_service_city:            dynamic_descriptor_merchant_service_city,
                merchant_service_country:         dynamic_descriptor_merchant_service_country,
                merchant_service_state:           dynamic_descriptor_merchant_service_state,
                merchant_service_zip_code:        dynamic_descriptor_merchant_service_zip_code,
                merchant_service_phone:           dynamic_descriptor_merchant_service_phone,
                merchant_service_geo_coordinates: dynamic_descriptor_merchant_service_geo_coordinates
              }
            end

          end
        end
      end
    end
  end
end
