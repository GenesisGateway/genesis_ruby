# frozen_string_literal: true

module GenesisRuby
  module Api
    module Mixins
      module Requests
        module CustomerAddress
          # Mixin shippingInfoAttributes
          module ShippingInfoAttributes

            attr_accessor :shipping_first_name, :shipping_last_name, :shipping_address1, :shipping_address2,
                          :shipping_zip_code, :shipping_city, :shipping_state, :shipping_country, :shipping_neighborhood

            protected

            # Build Hash with all parameters
            def shipping_address_parameters_structure # rubocop:disable Metrics/MethodLength
              {
                first_name:   shipping_first_name,
                last_name:    shipping_last_name,
                address1:     shipping_address1,
                address2:     shipping_address2,
                zip_code:     shipping_zip_code,
                city:         shipping_city,
                state:        shipping_state,
                neighborhood: shipping_neighborhood,
                country:      shipping_country
              }
            end

          end
        end
      end
    end
  end
end
