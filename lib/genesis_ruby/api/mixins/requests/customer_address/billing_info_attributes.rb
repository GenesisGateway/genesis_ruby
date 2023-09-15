module GenesisRuby
  module Api
    module Mixins
      module Requests
        module CustomerAddress
          # Mixin BillingInfoAttributes
          module BillingInfoAttributes

            attr_accessor :billing_first_name, :billing_last_name, :billing_address1, :billing_address2,
                          :billing_zip_code, :billing_city, :billing_state, :billing_country

            protected

            # Build Hash with all parameters
            def billing_address_parameters_structure
              {
                first_name: billing_first_name,
                last_name:  billing_last_name,
                address1:   billing_address1,
                address2:   billing_address2,
                zip_code:   billing_zip_code,
                city:       billing_city,
                state:      billing_state,
                country:    billing_country
              }
            end

          end
        end
      end
    end
  end
end
