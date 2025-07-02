# frozen_string_literal: true

module GenesisRuby
  module Api
    module Requests
      module NonFinancial
        module Consumers
          # Creates a consumer based on email address
          class Create < Base::Consumer

            include Api::Mixins::Requests::CustomerAddress::BillingInfoAttributes
            include Api::Mixins::Requests::CustomerAddress::ShippingInfoAttributes

            attr_accessor :email

            # Create Consumer constructor
            def initialize(configuration, _builder_interface = nil)
              super configuration

              self.request_path = 'create_consumer'
            end

            protected

            # Create Consumer field validations
            def init_field_validations
              super

              required_fields.push *%i[email]
            end

            # Create Consumer request structure
            def request_structure
              {
                email:            email,
                billing_address:  billing_address_parameters_structure,
                shipping_address: shipping_address_parameters_structure
              }
            end

          end
        end
      end
    end
  end
end
